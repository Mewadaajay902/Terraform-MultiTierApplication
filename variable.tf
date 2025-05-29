variable "resourcegroupname" {
    description = "Name of the resource group"
    type = string
}

variable "location" {
    description = "Name of the resource group location"
    type = string 
}

variable "virtualnetworkname" {
    type = string
    description = "Virtual network name"
}

variable "vnetadressspace" {
    type = string 
}

variable "jumpboxadressspace" {
  type = string
}

variable "vmname"{
    type = string
}

variable "vmssname" {
  type = string
}

variable "adminusername" {
  type = string
}

variable "adminpassword" {
    type = string
  
}

variable "websubnetadressspace" {
  type = string
}

variable "appgatewaysubnetadressspace" {
  type = string
}

variable "databasesubnetadressspace" {
  type = string
}

variable "keyvaultname" {
  type = string
}

variable "appgatewayname" {
  type = string
}

variable "cdnendpointname" {
  
}

variable "cdnprofilename" {
  
}

variable "database_name" {
  
}

variable "private_dns_zone_link_name" {
  
}

variable "private_dns_zone_name" {
  
}