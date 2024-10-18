resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = var.loadbalancer_id
  name                           = var.rule_name
  protocol                       = var.rule_protocol
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  disable_outbound_snat          = true
  frontend_ip_configuration_name = var.public_ip_name
  probe_id                       = var.probe_id
  backend_address_pool_ids       = var.backend_address_pool_ids
}


