provider "azurerm" {
  features {}
}

module "vm" {
  source  = "Azure/compute/azurerm"
  version = "3.0.0"  # Use the latest version available

  # Resource Group
  resource_group_name = azurerm_resource_group.this.name

  # VM Configuration
  vm_os_simple        = "Windows2019"
  admin_username      = var.adminuser
  admin_password      = var.admin_password
  vm_size             = "Standard_B1s"

  # Tags
  tags = {
    environment = "demo"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "AzureSpringClean2025"
  location = var.location
}

