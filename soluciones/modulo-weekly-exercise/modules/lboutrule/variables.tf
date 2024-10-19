

variable "lb_out_rule_name" {
  description = "Nombre de la regla de salida del Load Balancer"
  type        = string
}

variable "loadbalancer_id" {
  description = "ID del Load Balancer al cual pertenece la regla de salida"
  type        = string
}

variable "rule_protocol" {
  description = "Protocolo para la regla de salida, puede ser 'All', 'TCP', o 'UDP'"
  type        = string
}

variable "backend_address_pool_id" {
  description = "ID del Backend Address Pool asociado a la regla de salida"
  type        = string
}

variable "public_ip_name" {
  description = "Nombre de la configuración de IP pública para el Load Balancer"
  type        = string
}
