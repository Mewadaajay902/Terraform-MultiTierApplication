variable "resourcegroupname" {
    description = "Name of the resource group"
    type = string
}

variable "location" {
    description = "Name of the resource group location"
    type = string 
}

variable "vmname" {
  type = string
}

variable "jumpboxsubnetid" {
    type = string 
}

variable "adminusername" {
  type = string
}

variable "adminpassword" {
    type = string
  
}
