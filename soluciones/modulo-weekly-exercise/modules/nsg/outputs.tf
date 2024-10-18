
output "id" {
  description = "The ID of the virtual network."
  value       = azurerm_network_security_group.my-nsg.id
}

output "name" {
  description = "The name of the virtual network."
  value       = azurerm_network_security_group.my-nsg.name
}

