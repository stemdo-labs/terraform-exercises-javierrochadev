output "network_interface_backend_pool_association_ids" {
  description = "Lista de los IDs de las asociaciones entre las interfaces de red y el Backend Address Pool"
  value       = azurerm_network_interface_backend_address_pool_association.lb-pool-assoc[*].id
}

output "network_interface_ids" {
  description = "Lista de IDs de las interfaces de red asociadas al Backend Address Pool"
  value       = var.network_interface_ids
}

output "backend_address_pool_id" {
  description = "El ID del Backend Address Pool al que están asociadas las interfaces de red"
  value       = var.backend_address_pool_id
}

output "ip_configuration_name" {
  description = "Nombre de la configuración de IP pública utilizada en las interfaces de red"
  value       = var.public_ip_name
}
