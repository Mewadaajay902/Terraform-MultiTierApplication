output "virtualnetworkname" {
  value = azurerm_virtual_network.VirtualNetwork.name
}

output "jumpboxsubnetid" {
    value = azurerm_subnet.jumpbox.id 
}

output "websubnetid" {
  value = azurerm_subnet.websubnet.id
}

output "appgatewaysubnetid" {
    value = azurerm_subnet.appgatewaysubnet.id 
}

output "databasesubnetid" {
  value = azurerm_subnet.databasesubnet.id
}

output "virtualnetworkid" {
  value = azurerm_virtual_network.VirtualNetwork.id
}