output "snsga_ids" {

  value = azurerm_subnet_network_security_group_association.snsga[*].id
}


