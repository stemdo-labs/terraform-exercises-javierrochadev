resource "azurerm_virtual_network" "v_net" {
    name                     = var.vnet_name
    resource_group_name      = var.existent_resource_group_name
    location                 = var.location
    address_space            = var.vnet_address_space
    tags = {
      "owner_tag" = lookup(var.vnet_tags, "owner_tag", var.owner_tag)
      "environment_tag" = lookup(var.vnet_tags, "environment_tag", var.environment_tag)
    }
}
