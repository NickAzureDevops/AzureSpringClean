variable "location" {
  description = "The Azure Region in which all resources will be created."
  type        = string
  default     = "uksouth"
}

variable "adminuser" {
  description = "The admin username for the Windows Virtual Machine."
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  type        = string
  description = "The password for the Windows Virtual Machine."
}

variable "vnet_address_space" {
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_space" {
  default     = ["10.0.2.0/24"]
}

variable "backendAzureRmResourceGroupName" {
  description = "The name of the resource group where the backend storage account is located."
  type        = string
}

variable "backendAzureRmStorageAccountName" {
  description = "The name of the storage account for the backend."
  type        = string
}

variable "backendAzureRmContainerName" {
  description = "The name of the container in the storage account for the backend."
  type        = string
}

variable "backendAzureRmKey" {
  description = "The name of the state file in the backend container."
  type        = string
}