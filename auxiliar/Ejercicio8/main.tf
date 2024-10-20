terraform {
  required_version = ">= 0.12"
  required_providers{
   azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
  
    backend "azurerm"{
      storage_account_name = "stajrochadvfinlab"
      container_name       = "terraform-state"
      key                  = "terraform.tfstate"
      resource_group_name  = "rg-jrocha-dvfinlab"
    }

}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}


