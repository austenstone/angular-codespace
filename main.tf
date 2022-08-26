# Configure the Azure provider
terraform {
  backend "azurerm" {
    resource_group_name  = "GitHub"
    storage_account_name = "austengithubstorage"
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

data "azurerm_resource_group" "GitHub" {
  name = "GitHub"
}

// Web App
resource "azurerm_service_plan" "example" {
  name                = "example-plan"
  resource_group_name = data.azurerm_resource_group.GitHub.name
  location            = data.azurerm_resource_group.GitHub.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "example" {
  name                = "example-linux-web-app"
  resource_group_name = data.azurerm_resource_group.GitHub.name
  location            = data.azurerm_resource_group.GitHub.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {}
}

resource "azurerm_linux_web_app_slot" "example" {
  name           = "example-slot"
  app_service_id = azurerm_linux_web_app.example.id

  site_config {}
}

// Static Site

resource "azurerm_static_site" "web" {
  name                = "Web"
  location            = data.azurerm_resource_group.GitHub.location
  resource_group_name = data.azurerm_resource_group.GitHub.name
}

resource "azurerm_static_site" "container" {
  name                = "Web"
  location            = data.azurerm_resource_group.GitHub.location
  resource_group_name = data.azurerm_resource_group.GitHub.name
}

output "name" {
  value = azurerm_static_site.web.name
}

output "url" {
  value = azurerm_static_site.web.default_host_name
}

output "api_key" {
  value = azurerm_static_site.web.api_key
}

output "app_name" {
  value = azurerm_linux_web_app.example.name
}
