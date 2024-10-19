resource "azurerm_lb_outbound_rule" "lboutbound_rule" {
  name                    = var.lb_out_rule_name
  loadbalancer_id         = var.loadbalancer_id
  protocol                = var.rule_protocol
  backend_address_pool_id = var.backend_address_pool_id

  frontend_ip_configuration {
    name = var.public_ip_name
  }
}
