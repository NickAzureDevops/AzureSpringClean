terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}