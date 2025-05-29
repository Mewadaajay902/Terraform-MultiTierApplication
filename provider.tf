terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "terraform-backend"
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

