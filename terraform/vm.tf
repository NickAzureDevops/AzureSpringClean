provider "azurerm" {
  features {}
}

module "vm" {
  source  = "Azure/compute/azurerm"
  version = "3.0.0"  # Use the latest version available

  # Resource Group
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location

  # Network Interface
  subnet_id           = azurerm_subnet.subnet.id

  # VM Configuration
  vm_os_simple        = "Windows2019"
  admin_username      = var.adminuser
  admin_password      = var.admin_password
  vm_size             = "Standard_B1s"
  storage_os_disk     = {
    name              = "azurespringclean-os-disk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Tags
  tags = {
    environment = "demo"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "AzureSpringClean2025"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}