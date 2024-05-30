terraform {
  required_version = ">=1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.11.0, <4.0"
    }
  }
}

provider "azurerm" {
  features {}
    subscription_id = "097f24e6-7d2c-439a-b79e-1029c5ed0fa0"
  }
# Alias provider for subscription1 subscription
provider "azurerm" {
  features {}
  alias           = "subscription1"
  subscription_id = "097f24e6-7d2c-439a-b79e-1029c5ed0fa0"
}