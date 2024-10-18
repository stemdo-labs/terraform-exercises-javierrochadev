# Outputs para las máquinas virtuales
output "linux_virtual_machine_ids" {
  description = "IDs de las máquinas virtuales"
  value       = azurerm_linux_virtual_machine.vm[*].id
}


output "linux_virtual_machine_names" {
  description = "Nombres de las máquinas virtuales"
  value       = azurerm_linux_virtual_machine.vm[*].name
}

output "linux_virtual_machine_admin_usernames" {
  description = "Nombres de usuario de las máquinas virtuales"
  value       = azurerm_linux_virtual_machine.vm[*].admin_username
}

output "linux_virtual_machine_sizes" {
  description = "Tamaños de las máquinas virtuales"
  value       = azurerm_linux_virtual_machine.vm[*].size
}

