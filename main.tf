# Configure the Azure provider
terraform {
  backend "azurerm" {
    resource_group_name  = "GitHub"
    storage_account_name = "austengithubstorage_1661452699092"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
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

data "azurerm_resource_group" "angular-codespace" {
  name     = "GitHub"
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
