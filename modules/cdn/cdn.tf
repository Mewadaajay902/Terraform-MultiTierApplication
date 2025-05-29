# Creates an Azure CDN profile with the specified name, location, resource group, and SKU.
resource "azurerm_cdn_profile" "web-static" {
    name                = var.cdnprofilename
    location            = var.location
    resource_group_name = var.resourcegroupname
    sku                 = "Standard_Microsoft"
}

# Creates an Azure CDN endpoint with the specified name, profile, location, resource group, and origin.
resource "azurerm_cdn_endpoint" "web-static" {
    name                = var.cdnendpointname
    profile_name        = azurerm_cdn_profile.web-static.name
    location            = var.location
    resource_group_name = var.resourcegroupname

    origin {
        name      = "webstatic"
        host_name = var.appgatewaypublicipaddress
        http_port = 80
    }
}