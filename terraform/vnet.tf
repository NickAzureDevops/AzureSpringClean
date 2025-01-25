resource "azurerm_virtual_network" "example" {
  name                = "vnet-azurespringclean2025"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-azurespringclean2025"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_space
}

resource "azurerm_public_ip" "pub" {
  name                = "pip-azurespringclean2025"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Dynamic"
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
