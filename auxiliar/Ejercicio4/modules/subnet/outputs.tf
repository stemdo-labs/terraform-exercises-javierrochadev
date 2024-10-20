output "subnet_ids"{
    description = "Lista con los valores de los ids de las subredes creadas"
    value = azurerm_subnet.v_net_subnet[*].id
}