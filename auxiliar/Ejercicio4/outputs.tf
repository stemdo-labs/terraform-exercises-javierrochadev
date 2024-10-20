
output "vnet_id" {
  description = "El ID de la red virtual creada."
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "El nombre de la red virtual creada."
  value       = module.vnet.vnet_name
}

output "vnet_address_space" {
  description = "El espacio de direcciones de la red virtual."
  value       = module.vnet.vnet_address_space
}

output "subnet_ids" {
  description = "Los IDs de las subredes creadas dentro de la red virtual."
  value       = module.vnet.subnet_ids
}

output "subnet_names" {
  description = "Los nombres de las subredes creadas dentro de la red virtual."
  value       = module.vnet.subnet_names
}

output "owner_tag" {
  description = "La etiqueta de propietario asociada a la red virtual."
  value       = module.vnet.owner_tag
}

output "environment_tag" {
  description = "La etiqueta de entorno asociada a la red virtual."
  value       = module.vnet.environment_tag
}

output "vnet_tags" {
  description = "Las etiquetas asociadas a la red virtual."
  value       = module.vnet.vnet_tags
}
