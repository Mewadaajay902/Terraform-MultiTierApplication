data "external" "myip" {
  program = ["${path.module}/getmyip.sh"]
}

locals {
    myip = tostring(data.external.myip.result["myip"])
}

resource "azurerm_virtual_network" "VirtualNetwork" {
    name = var.virtualnetworkname
    resource_group_name = var.resourcegroupname
    location = var.location
    address_space = [ var.vnetadressspace ] 
}

resource "azurerm_subnet" "jumpbox" {
    name = "jumbbox-subnet"
    resource_group_name = var.resourcegroupname
    virtual_network_name = azurerm_virtual_network.VirtualNetwork.name
    address_prefixes = [var.jumpboxadressspace]
  
}

resource "azurerm_subnet" "websubnet" {
    name = "websubnet-subnet"
    resource_group_name = var.resourcegroupname
    virtual_network_name = azurerm_virtual_network.VirtualNetwork.name
    address_prefixes = [var.websubnetadressspace]
  
}

resource "azurerm_subnet" "appgatewaysubnet" {
    name = "appgateway-subnet"
    resource_group_name = var.resourcegroupname
    virtual_network_name = azurerm_virtual_network.VirtualNetwork.name
    address_prefixes = [var.appgatewaysubnetaddessspace]
  
}

resource "azurerm_subnet" "databasesubnet" {
    name = "database-subnet"
    resource_group_name = var.resourcegroupname
    virtual_network_name = azurerm_virtual_network.VirtualNetwork.name
    address_prefixes = [var.databasesubnetadressspace]

    delegation {
    name = "database-delegation"

    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
  
}

# NSG rules for jumpbox subnet
resource "azurerm_network_security_group" "jumpbox_nsg" {
    name                = "jumpbox-nsg"
    location            = var.location
    resource_group_name = var.resourcegroupname

    security_rule {
        name                       = "AllowSSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*" # Use the dynamic IP
        destination_address_prefix = var.jumpboxadressspace
    }
}

# NSG rules for web tier subnet
resource "azurerm_network_security_group" "web_tier_nsg" {
    name                = "web-tier-nsg"
    location            = var.location
    resource_group_name = var.resourcegroupname

    security_rule {
        name                       = "AllowHTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = var.websubnetadressspace
    }
}

# NSG rules for database subnet
resource "azurerm_network_security_group" "database_nsg" {
    name                = "database-nsg"
    location            = var.location
    resource_group_name = var.resourcegroupname

    security_rule {
        name                       = "AllowMySQL"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3306"
        source_address_prefix      = "*"
        destination_address_prefix = var.databasesubnetadressspace
    }
}

# Attach NSG to subnets
resource "azurerm_subnet_network_security_group_association" "jumpbox_nsg_association" {
    subnet_id                 = azurerm_subnet.jumpbox.id
    network_security_group_id = azurerm_network_security_group.jumpbox_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "web_tier_nsg_association" {
    subnet_id                 = azurerm_subnet.websubnet.id
    network_security_group_id = azurerm_network_security_group.web_tier_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "database_nsg_association" {
    subnet_id                 = azurerm_subnet.databasesubnet.id
    network_security_group_id = azurerm_network_security_group.database_nsg.id
}