resource "azurerm_linux_virtual_machine" "vm" {
  count                 = length(var.virtual_machines)
  name                  = var.virtual_machines[count.index].name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = tolist([var.network_interface_ids[count.index]])
  size                  = var.virtual_machines[count.index].size

  os_disk {
    name                 = var.virtual_machines[count.index].disk_name
    caching              = "ReadWrite"
    storage_account_type = var.virtual_machines[count.index].storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_username                  = var.virtual_machines[count.index].username
  admin_password                  = var.virtual_machines[count.index].password
  disable_password_authentication = false

}