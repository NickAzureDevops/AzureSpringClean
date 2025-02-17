provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name   = var.backendAzureRmResourceGroupName
    storage_account_name  = var.backendAzureRmStorageAccountName
    container_name        = var.backendAzureRmContainerName
    key                   = var.backendAzureRmKey
  }
}