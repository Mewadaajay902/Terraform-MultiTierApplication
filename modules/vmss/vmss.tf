resource "azurerm_linux_virtual_machine_scale_set" "webvmss" {
  name                = var.vmssname
  resource_group_name = var.resourcegroupname
  location            = var.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = var.adminusername
  admin_password      = var.adminpassword

  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.vmssname}-nic"
    primary = true

    ip_configuration {
      name      = "ipconfig2"
      primary   = true
      subnet_id = var.websubnetid
      #application_gateway_backend_address_pool_ids = var.appgatewayid
    }
  }
  custom_data = filebase64("./modules/vmss/customscript.sh")
}
