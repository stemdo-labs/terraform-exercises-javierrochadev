
output "vnet_id" {
  description = "The ID of the virtual network."
  value       = azurerm_network_security_group.my-nsg.id
}

output "vnet_name" {
  description = "The name of the virtual network."
  value       = azurerm_network_security_group.my-nsg.name
}



output "vnet_location" {
  description = "The location of the virtual network."
  value       = azurerm_network_security_group.my-nsg.location
}

output "vnet_resource_group_name" {
  description = "The name of the resource group where the virtual network resides."
  value       = azurerm_network_security_group.my-nsg.resource_group_name
}