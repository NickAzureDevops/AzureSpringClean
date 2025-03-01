provider "azurerm" {
  features {}
}

module "linuxservers" {
  source              = "Azure/terraform-azurerm-avm-res-compute-virtualmachine"
  version             = "1.0.0"  
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location

  vm_os_simple        = "UbuntuServer"
  admin_username      = var.adminuser
  admin_password      = var.admin_password
  vm_size             = "Standard_B1s"
  public_ip_dns       = ["linsimplevmips"]
  vnet_subnet_id      = azurerm_subnet.subnet.id

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