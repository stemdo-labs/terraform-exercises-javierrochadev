resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id     = var.loadbalancer_id
  name                = var.lb_probe_name
  port                = var.port
}