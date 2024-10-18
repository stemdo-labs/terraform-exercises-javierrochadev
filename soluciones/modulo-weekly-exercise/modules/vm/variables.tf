variable "virtual_machines" {
  description = "Lista de objetos con los parametros de las maquinas virtuales."
  type        = list(object({
    name                      = string
    size                      = string
    disk_name                 = string
    storage_account_type      = string
    username                  = string
    password                  = string

  }))
}

variable "location" {
  description = "Ubicación de los recursos en Azure."
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos de Azure donde se crearán los recursos."
  type        = string
}

variable "network_interface_ids" {
  description = "Lista con los ids de todas las interfaces de red."
  type        = list(string)
}











