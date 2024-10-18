output "network_interface_ids" {
  description = "Lista de IDs de las interfaces de red creadas"
  value       = azurerm_network_interface.interface[*].id
}

output "network_interface_names" {
  description = "Lista de nombres de las interfaces de red creadas"
  value       = azurerm_network_interface.interface[*].name
}

output "network_interface_private_ips" {
  description = "Lista de direcciones IP privadas asignadas a las interfaces de red"
  value       = [for nic in azurerm_network_interface.interface[*] : nic.ip_configuration[0].private_ip_address]
}

output "network_interface_primary_private_ips" {
  description = "Lista de flags que indican si la IP privada es la principal (true)"
  value       = [for nic in azurerm_network_interface.interface[*] : nic.ip_configuration[0].primary]
}

output "network_interface_subnet_ids" {
  description = "Lista de IDs de las subredes a las que están asociadas las interfaces de red"
  value       = [for nic in azurerm_network_interface.interface[*] : nic.ip_configuration[0].subnet_id]
}
