output "network_security_group_id"{
    description = "Es el id del grupo de seguridad creado"
    value = azurerm_network_security_group.nsg.id
}