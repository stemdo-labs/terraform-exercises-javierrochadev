resource "azurerm_subnet_network_security_group_association" "snsga" {
  count                     = length(var.subnet_ids)
  subnet_id                 = var.subnet_ids[count.index]
  network_security_group_id = var.network_security_group_id
}