resource "azurerm_network_interface" "interface" {
  count               = length(var.subnet_ids)
  name                = "${var.network_interface_name}${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ip${count.index}"
    subnet_id                     = var.subnet_ids[count.index]
    private_ip_address_allocation = "Dynamic"
    primary = true
  }
}