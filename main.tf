# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "austenstone-rg" {
  name     = "myTFResourceGroup"
  location = "eastus"
}

resource "azurerm_static_site" "web" {
  name                = "angular-web"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
}
