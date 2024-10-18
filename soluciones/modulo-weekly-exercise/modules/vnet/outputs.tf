
output "vnet_id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  description = "The address space of the virtual network."
  value       = azurerm_virtual_network.vnet.address_space
}

output "vnet_location" {
  description = "The location of the virtual network."
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_resource_group_name" {
  description = "The name of the resource group where the virtual network resides."
  value       = azurerm_virtual_network.vnet.resource_group_name
}