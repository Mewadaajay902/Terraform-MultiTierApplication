variable "resourcegroupname" {
  type = string
  description = "resource group name"
}

variable "virtualnetworkname" {
    type = string
    description = "Virtual network name"
}

variable "vnetadressspace" {
    type = string 
}

variable "location" {
  type = string
}

variable "jumpboxadressspace" {

}

variable "websubnetadressspace" {

}

variable "appgatewaysubnetaddessspace" {

}

variable "databasesubnetadressspace" {

}