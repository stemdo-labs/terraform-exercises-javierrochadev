terraform {
  required_version = ">= 0.12"
  required_providers{
   azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}
 
import {
  to = azurerm_linux_virtual_machine.test-vm1
  id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Compute/virtualMachines/test-vm1"
}
import {
  to = azurerm_linux_virtual_machine.test-vm3
  id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Compute/virtualMachines/test-vm3"
}



