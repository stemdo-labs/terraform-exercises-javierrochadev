output "lb_probe_id" {
  description = "The ID of the load balancer probe."
  value       = azurerm_lb_probe.lb_probe.id
}

output "lb_probe_name" {
  description = "The name of the load balancer probe."
  value       = azurerm_lb_probe.lb_probe.name
}

output "lb_probe_port" {
  description = "The port on which the load balancer probe is checking health."
  value       = azurerm_lb_probe.lb_probe.port
}

output "load_balancer_id" {
  description = "The ID of the load balancer associated with the probe."
  value       = azurerm_lb_probe.lb_probe.loadbalancer_id
}
