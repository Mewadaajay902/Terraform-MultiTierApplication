module "resourcegroupmodule" {
  source = "./modules/resource-group"
  resourcegroupname = var.resourcegroupname
  location = var.location
}

module "virtualnetworkmodule" {
  source = "./modules/virtual-network"  
  virtualnetworkname = var.virtualnetworkname
  vnetadressspace = var.vnetadressspace
  resourcegroupname = var.resourcegroupname
  location = var.location
  jumpboxadressspace = var.jumpboxadressspace
  websubnetadressspace = var.websubnetadressspace
  appgatewaysubnetaddessspace = var.appgatewaysubnetadressspace
  databasesubnetadressspace = var.databasesubnetadressspace
  depends_on = [ module.resourcegroupmodule ]
 }

module "jumpbox" {
  source = "./modules/jumpbox"
  resourcegroupname = var.resourcegroupname
  location = var.location
  vmname = var.vmname
  jumpboxsubnetid = module.virtualnetworkmodule.jumpboxsubnetid
  adminusername = var.adminusername
  adminpassword = var.adminpassword
  
  depends_on = [ module.virtualnetworkmodule  , module.resourcegroupmodule]
}

module "keyvault" {
    source = "./modules/keyvault"
    resourcegroupname = var.resourcegroupname
    location = var.location
    keyvaultname = var.keyvaultname

    depends_on = [ module.resourcegroupmodule , module.jumpbox]
  
}

module "appgateway" {
    source = "./modules/appgateway"
    resourcegroupname = var.resourcegroupname
    location = var.location  
    appgatewayname = var.appgatewayname
    appgatewaysubnetid = module.virtualnetworkmodule.appgatewaysubnetid
    user_assigned_identity_id = module.keyvault.user_assigned_identity_id
    keyvalut_Secret_Identifier = module.keyvault.keyvalut_Secret_Identifier

    depends_on = [ module.virtualnetworkmodule , module.keyvault , module.resourcegroupmodule]
  
}

# module "cdn" {
#     source = "./modules/cdn"
#     resourcegroupname = var.resourcegroupname
#     location = var.location
#     cdnendpointname = var.cdnendpointname
#     cdnprofilename = var.cdnprofilename
#     appgatewaypublicipaddress = module.appgateway.appgatewaypublicipaddress

#     depends_on = [ module.appgateway , module.resourcegroupmodule]
# }

module "vmss" {
  source = "./modules/vmss"
  resourcegroupname = var.resourcegroupname
  location = var.location
  vmssname = var.vmssname
  websubnetid =  module.virtualnetworkmodule.websubnetid
  adminusername = var.adminusername
  adminpassword = var.adminpassword
  appgatewayid = module.appgateway.appgatewayid

  depends_on = [ module.appgateway , module.virtualnetworkmodule , module.resourcegroupmodule]
}

# module "database" {
#     source = "./modules/database"
#     resourcegroupname = var.resourcegroupname
#     location = var.location
#     private_dns_zone_name = var.private_dns_zone_name
#     private_dns_zone_link_name = var.private_dns_zone_link_name
#     virtual_network_id = module.virtualnetworkmodule.virtualnetworkid
#     database_subnet_id = module.virtualnetworkmodule.databasesubnetid
#     database_name = var.database_name
#     admin_username = var.adminusername
#     admin_password = var.adminpassword

#     depends_on = [ module.virtualnetworkmodule , module.resourcegroupmodule]

# }

