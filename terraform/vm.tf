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

resource "azurerm_public_ip" "pub" {
  name                = "pip-azurespringclean2025"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-azurespringclean2025"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub.id
  }
}