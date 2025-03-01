variable "location" {
  description = "The Azure region to deploy resources in"
  default     = "East US"
}

variable "adminuser" {
  description = "The admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
  sensitive   = true
}