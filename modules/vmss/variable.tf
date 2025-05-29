variable "vmssname" {
  type = string
  description = "virtual machine scale-set name"
}

variable "resourcegroupname" {
    description = "Name of the resource group"
    type = string
}

variable "location" {
    description = "Name of the resource group location"
    type = string 
}

variable "websubnetid" {
  #type = string
}

variable "adminusername" {
  type = string
}

variable "adminpassword" {
    type = string
  
}

variable "appgatewayid" {

}