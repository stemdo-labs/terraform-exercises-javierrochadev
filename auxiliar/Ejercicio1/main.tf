terraform {
  required_version = ">= 0.12"
  required_providers{
   azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}
 
import {
  to = azurerm_network_security_group.main_sec_group
  id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Network/networkSecurityGroups/main-sec-group"
}
import {
  to = azurerm_virtual_network.main_vnet
  id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Network/virtualNetworks/main-vnet"
}

import {
  to = azurerm_virtual_network.main_vnet_tf
  id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Network/virtualNetworks/main-vnet-tf"
}


# import {
#   to = azurerm_network_interface.test_interface0
#   id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Network/networkInterfaces/test-interface0"
# }

# import {
#   to = azurerm_public_ip.test_ip
#   id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Network/publicIPAddresses/test-ip"
# }
import {
  to = azurerm_public_ip.test_ip_public
  id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Network/publicIPAddresses/test-ip-public"
}
import {
  to = azurerm_load_balancer.test_lb
  id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Network/loadBalancers/test-lb"
}
# import {
#   to = azurerm_virtual_machine.test_vm1
#   id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Compute/virtualMachines/test-vm1"
# }
# import {
#   to = azurerm_managed_disk.test_vm1_disk
#   id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/RG-JROCHA-DVFINLAB/providers/Microsoft.Compute/disks/test-vm1-disk"
# }
