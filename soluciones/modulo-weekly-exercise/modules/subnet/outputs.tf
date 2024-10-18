output "subnet_ids" {
  value = azurerm_subnet.subnet[*].id
}

output "subnet_names" {
  value = azurerm_subnet.subnet[*].name
}

