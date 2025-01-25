resource "azurerm_resource_group" "this" {
  name     = "AzureSpringClean2025"
  location = var.location
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "azurespringclean2025-vm"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  size                = "Standard_DS1_v2"

  admin_username = var.adminuser
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    name              = "azurespringclean-os-disk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}