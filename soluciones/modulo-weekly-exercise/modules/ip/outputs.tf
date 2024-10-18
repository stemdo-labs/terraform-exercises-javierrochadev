output "public_ip_name" {
  description = "El nombre de la IP pública"
  value       = azurerm_public_ip.public-ip.name
}

output "public_ip_location" {
  description = "La ubicación donde se encuentra la IP pública"
  value       = azurerm_public_ip.public-ip.location
}

output "public_ip_resource_group_name" {
  description = "El nombre del grupo de recursos donde está la IP pública"
  value       = azurerm_public_ip.public-ip.resource_group_name
}

output "public_ip_allocation_method" {
  description = "El método de asignación de la IP pública (Static o Dynamic)"
  value       = azurerm_public_ip.public-ip.allocation_method
}

output "public_ip_sku" {
  description = "El SKU (nivel de servicio) de la IP pública"
  value       = azurerm_public_ip.public-ip.sku
}

output "public_ip_address" {
  description = "La dirección IP pública asignada"
  value       = azurerm_public_ip.public-ip.ip_address
}

output "public_ip_id" {
  description = "El ID de la IP pública"
  value       = azurerm_public_ip.public-ip.id
}
