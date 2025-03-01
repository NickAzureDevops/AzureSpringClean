resource "azurerm_linux_virtual_machine" "linuxservers" {
  name                = "linuxservers"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.adminuser
  admin_password      = var.admin_password 
  network_interface_ids = [azurerm_network_interface.linuxservers.id]
  zone                = "1"
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = "sandbox"
    application = "azurespringclean"
  }
}

resource "azurerm_network_interface" "linuxservers" {
  name                = "linuxservers-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linuxservers.id
  }

  tags = {
    environment = "sandbox"
    application = "azurespringclean"
  }
}

resource "azurerm_public_ip" "linuxservers" {
  name                = "linuxservers-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "sandbox"
    application = "azurespringclean"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "AzureSpringClean2025"
  location = var.location

  tags = {
    environment = "sandbox"
    application = "azurespringclean"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  
  tags = {
    environment = "sandbox"
    application = "azurespringclean"
  }
}
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}