resource "azurerm_network_interface" "name" {
    name = "${var.vmname}-nic"
    location = var.location
    resource_group_name = var.resourcegroupname

    ip_configuration {
      name = "ipconfig1"
      subnet_id = var.jumpboxsubnetid
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.vmpublicip.id
    }
}

resource "azurerm_public_ip" "vmpublicip" {
   name = "${var.vmname}-publicip"
   location = var.location
   resource_group_name = var.resourcegroupname

   allocation_method = "Static"
   sku = "Standard"
}

resource "azurerm_linux_virtual_machine" "jumbboxvm" {
  name                = var.vmname
  location = var.location
  resource_group_name = var.resourcegroupname
  size                = "Standard_F2"
  admin_username      = var.adminusername
  admin_password         = var.adminpassword
  network_interface_ids = [
    azurerm_network_interface.name.id,
  ]
  disable_password_authentication = false
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
