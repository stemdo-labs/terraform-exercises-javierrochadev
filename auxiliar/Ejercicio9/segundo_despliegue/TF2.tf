terraform {
  required_version = ">= 0.12"
  required_providers{
   azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
  
    # backend "azurerm"{
    #   storage_account_name = "stajrochadvfinlab"
    #   container_name       = "terraform-state"
    #   key                  = "terraform.tfstate"
    #   resource_group_name  = "rg-jrocha-dvfinlab"
    # }

}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}

# import {
#   to = azurerm_storage_account.vaultaccount
#   id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Storage/storageAccounts/vaultaccount"
# }
# import {
#   to = azurerm_key_vault.tf1-key-vault
#   id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.KeyVault/vaults/tf1-key-vault"
# }





