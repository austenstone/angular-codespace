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

resource "azurerm_resource_group" "angular-codespace" {
  name     = "myTFResourceGroup"
  location = "eastus2"
}

resource "azurerm_static_site" "web" {
  name                = "angular-web"
  location            = azurerm_resource_group.angular-codespace.location
  resource_group_name = azurerm_resource_group.angular-codespace.name
}

output "name" {
  value = azurerm_static_site.web.name
}

output "url" {
  value = azurerm_static_site.web.default_host_name
}
