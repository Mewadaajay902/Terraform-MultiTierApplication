output "appgatewayid" {
    value = azurerm_application_gateway.network.backend_address_pool[*].id
  
}

output "appgatewaypublicip" {
  value = azurerm_public_ip.app_gateway_public_ip.id
}

output "appgatewaypublicipaddress" {
  value = azurerm_public_ip.app_gateway_public_ip.ip_address
}