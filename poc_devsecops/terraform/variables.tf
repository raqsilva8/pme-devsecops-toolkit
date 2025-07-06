variable "azure_location" {
  description = "Azure region to deploy to"
}

variable "acr_name" {
  description = "Azure Container Registry name (must be globally unique, 5-50 alphanumeric chars)"
  type        = string
}

variable "key_vault_name" {
  description = "Azure Key Vault name (must be globally unique, 3-24 alphanumeric chars)"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "vm_size" {
  description = "Azure VM size"
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "sp_object_id" {
  description = "The object ID of the service principal for CI/CD (GitHub Actions) to access Key Vault."
  type        = string
}

