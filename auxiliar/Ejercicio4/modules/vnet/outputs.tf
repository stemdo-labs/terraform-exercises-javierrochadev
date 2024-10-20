output "vnet_name" {
  description = "El nombre de la red virtual creada"
  value       = azurerm_virtual_network.v_net.name
}