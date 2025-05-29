resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = "${var.appgatewayname}-publicip"
  resource_group_name = var.resourcegroupname
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Defines local variables for re-used values
locals {
  backend_address_pool_name      = "${var.appgatewayname}-beap"
  frontend_port_name             = "${var.appgatewayname}-feport"
  frontend_ip_configuration_name = "${var.appgatewayname}-feip"
  http_setting_name              = "${var.appgatewayname}-be-htst"
  listener_name                  = "${var.appgatewayname}-httplstn"
  request_routing_rule_name      = "${var.appgatewayname}-rqrt"
  redirect_configuration_name    = "${var.appgatewayname}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = var.appgatewayname
  resource_group_name = var.resourcegroupname
  location            = var.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "${var.appgatewayname}-ipconfig"
    subnet_id = var.appgatewaysubnetid
  }

  frontend_port {
    name = local.frontend_port_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name = "app_listener"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }

  ssl_certificate {
    name = "app_listener"
    key_vault_secret_id = var.keyvalut_Secret_Identifier
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = 100
  }

  depends_on = [ 
    azurerm_public_ip.app_gateway_public_ip
    ]
}