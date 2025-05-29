

variable "resourcegroupname" {
  description = "Name of the resource group"
}
  
variable "location" {
  description = "Azure region"
}

variable "private_dns_zone_name" {
  description = "Name of the private DNS zone"
}

variable "private_dns_zone_link_name" {
  description = "Name of the private DNS zone link"
}

variable "virtual_network_id" {
  description = "ID of the virtual network"
}

variable "database_subnet_id" {
  description = "ID of the database subnet"
}

variable "database_name" {
  description = "Name of the database"
}

variable "admin_username" {
  description = "Admin username for the MySQL server"
}
  
variable "admin_password" {
  description = "Admin password for the MySQL server"
}