output "lb_rule_id" {
  description = "The ID of the load balancer rule."
  value       = azurerm_lb_rule.lb_rule.id
}

output "lb_rule_name" {
  description = "The name of the load balancer rule."
  value       = azurerm_lb_rule.lb_rule.name
}

output "lb_rule_protocol" {
  description = "The protocol used by the load balancer rule (e.g., Tcp, Udp)."
  value       = azurerm_lb_rule.lb_rule.protocol
}

output "lb_rule_frontend_port" {
  description = "The frontend port used by the load balancer rule."
  value       = azurerm_lb_rule.lb_rule.frontend_port
}

output "lb_rule_backend_port" {
  description = "The backend port used by the load balancer rule."
  value       = azurerm_lb_rule.lb_rule.backend_port
}

output "lb_rule_disable_outbound_snat" {
  description = "Indicates whether outbound SNAT is disabled for the load balancer rule."
  value       = azurerm_lb_rule.lb_rule.disable_outbound_snat
}

output "lb_rule_probe_id" {
  description = "The ID of the health probe associated with the load balancer rule."
  value       = azurerm_lb_rule.lb_rule.probe_id
}

output "lb_rule_backend_address_pool_ids" {
  description = "The backend address pool IDs associated with the load balancer rule."
  value       = azurerm_lb_rule.lb_rule.backend_address_pool_ids
}
