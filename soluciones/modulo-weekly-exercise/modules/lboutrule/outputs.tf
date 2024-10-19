output "lb_outbound_rule_id" {
  description = "El ID de la regla de salida del Load Balancer"
  value       = azurerm_lb_outbound_rule.lboutbound_rule.id
}

output "lb_outbound_rule_name" {
  description = "El nombre de la regla de salida del Load Balancer"
  value       = azurerm_lb_outbound_rule.lboutbound_rule.name
}

output "lb_outbound_rule_protocol" {
  description = "El protocolo de la regla de salida del Load Balancer"
  value       = azurerm_lb_outbound_rule.lboutbound_rule.protocol
}

output "lb_outbound_rule_backend_address_pool_id" {
  description = "El ID del Backend Address Pool asociado a la regla de salida"
  value       = azurerm_lb_outbound_rule.lboutbound_rule.backend_address_pool_id
}

output "lb_outbound_rule_frontend_ip_configuration_name" {
  description = "El nombre de la configuración de IP pública del frontend"
  value       = azurerm_lb_outbound_rule.lboutbound_rule.frontend_ip_configuration[0].name
}

output "lb_outbound_rule_idle_timeout_in_minutes" {
  description = "El tiempo de inactividad de la regla de salida del Load Balancer en minutos"
  value       = azurerm_lb_outbound_rule.lboutbound_rule.idle_timeout_in_minutes
}

output "lb_outbound_rule_allocated_outbound_ports" {
  description = "El número de puertos asignados para la conectividad saliente"
  value       = azurerm_lb_outbound_rule.lboutbound_rule.allocated_outbound_ports
}
