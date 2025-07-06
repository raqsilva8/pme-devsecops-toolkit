output "public_ip" {
  value = azurerm_public_ip.django_public_ip.ip_address
}
