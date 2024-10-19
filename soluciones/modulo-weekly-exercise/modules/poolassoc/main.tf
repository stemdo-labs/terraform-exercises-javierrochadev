resource "azurerm_network_interface_backend_address_pool_association" "lb-pool-assoc" {
  count                   = length(var.network_interface_ids)
  network_interface_id    = var.network_interface_ids[count.index]
  ip_configuration_name   = "ip${count.index}" 
  backend_address_pool_id = var.backend_address_pool_id
}


