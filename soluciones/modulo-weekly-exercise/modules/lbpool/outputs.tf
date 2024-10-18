output "backend_address_pool_id" {
  description = "The ID of the backend address pool."
  value       = azurerm_lb_backend_address_pool.lb_pool.id
}

output "backend_address_pool_name" {
  description = "The name of the backend address pool."
  value       = azurerm_lb_backend_address_pool.lb_pool.name
}

output "load_balancer_id" {
  description = "The ID of the load balancer to which the backend address pool is associated."
  value       = azurerm_lb_backend_address_pool.lb_pool.loadbalancer_id
}
