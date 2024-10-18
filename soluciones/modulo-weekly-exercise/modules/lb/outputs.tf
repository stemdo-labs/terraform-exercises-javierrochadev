output "load_balancer_id" {
  description = "El ID del balanceador de carga."
  value       = azurerm_lb.lb.id
}

output "load_balancer_name" {
  description = "El nombre del balanceador de carga."
  value       = azurerm_lb.lb.name
}

output "load_balancer_location" {
  description = "La ubicación del balanceador de carga."
  value       = azurerm_lb.lb.location
}

output "load_balancer_sku" {
  description = "El SKU del balanceador de carga."
  value       = azurerm_lb.lb.sku
}

output "frontend_ip_configuration_name" {
  description = "El nombre de la configuración de la IP pública asociada al balanceador de carga."
  value       = azurerm_lb.lb.frontend_ip_configuration[0].name
}

output "frontend_ip_configuration_id" {
  description = "El ID de la configuración de la IP pública asociada al balanceador de carga."
  value       = azurerm_lb.lb.frontend_ip_configuration[0].id
}

output "public_ip_address_id" {
  description = "El ID de la dirección IP pública asociada al balanceador de carga."
  value       = azurerm_lb.lb.frontend_ip_configuration[0].public_ip_address_id
}
