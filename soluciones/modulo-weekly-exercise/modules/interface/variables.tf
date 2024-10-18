variable "network_interface_name" {
  description = "Nombre para la interfaz de red."
  type        = string
}

variable "location" {
  description = "Ubicación de los recursos en Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos de Azure donde se crearán los recursos"
  type        = string
}

variable "subnet_ids" {
  description = "Lista con los ids de todos las subredes creadas."
  type        = list(string)
}




