variable "network_interface_ids" {
  description = "Lista de IDs de las interfaces de red que se van a asociar al backend pool del Load Balancer"
  type        = list(string)
}

variable "public_ip_name" {
  description = "Nombre de la configuración de IP pública asociada a la interfaz de red"
  type        = string
}

variable "backend_address_pool_id" {
  description = "ID del Backend Address Pool al cual se asociarán las interfaces de red"
  type        = string
}
