resource "azurerm_lb" "lb" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  frontend_ip_configuration {
    name                 = var.public_ip_name
    public_ip_address_id = var.public_ip_address_id
  }
}