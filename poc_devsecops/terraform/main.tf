resource "azurerm_resource_group" "django" {
  name     = "poc_resource_group"
  location = var.azure_location
}

resource "azurerm_virtual_network" "django_vnet" {
  name                = "django-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.django.location
  resource_group_name = azurerm_resource_group.django.name
}

resource "azurerm_subnet" "django_subnet" {
  name                 = "django-subnet"
  resource_group_name  = azurerm_resource_group.django.name
  virtual_network_name = azurerm_virtual_network.django_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "django_nsg" {
  name                = "django-nsg"
  location            = azurerm_resource_group.django.location
  resource_group_name = azurerm_resource_group.django.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "django_public_ip" {
  name                = "django-public-ip"
  location            = azurerm_resource_group.django.location
  resource_group_name = azurerm_resource_group.django.name
  allocation_method   = "Static"
}

resource "azurerm_container_registry" "django_acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.django.name
  location            = azurerm_resource_group.django.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_key_vault" "django_kv" {
  name                        = var.key_vault_name
  location                    = azurerm_resource_group.django.location
  resource_group_name         = azurerm_resource_group.django.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = false
}

resource "azurerm_user_assigned_identity" "django_identity" {
  name                = "django-identity"
  resource_group_name = azurerm_resource_group.django.name
  location            = azurerm_resource_group.django.location
}

resource "azurerm_linux_virtual_machine" "django_vm" {
  name                = "django-vm"
  resource_group_name = azurerm_resource_group.django.name
  location            = azurerm_resource_group.django.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.django_nic.id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "django-osdisk"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.django_identity.id]
  }
  custom_data = base64encode(templatefile("${path.module}/docker_run.sh.tpl", {
    public_ip = azurerm_public_ip.django_public_ip.ip_address
  }))
}

resource "azurerm_network_interface" "django_nic" {
  name                = "django-nic"
  location            = azurerm_resource_group.django.location
  resource_group_name = azurerm_resource_group.django.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.django_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.django_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "django_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.django_nic.id
  network_security_group_id = azurerm_network_security_group.django_nsg.id
}

resource "azurerm_key_vault_access_policy" "sp" {
  key_vault_id = azurerm_key_vault.django_kv.id
  tenant_id    = var.tenant_id
  object_id    = var.sp_object_id

  secret_permissions = [
    "Get",
    "List"
  ]
}
