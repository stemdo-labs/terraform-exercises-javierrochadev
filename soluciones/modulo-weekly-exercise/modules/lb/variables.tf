variable "load_balancer_name" {
  description = "El nombre del balanceador de carga."
  type        = string
}

variable "location" {
  description = "La ubicación geográfica donde se desplegará el balanceador de carga."
  type        = string
}

variable "resource_group_name" {
  description = "El nombre del grupo de recursos donde se creará el balanceador de carga."
  type        = string
}

variable "sku" {
  description = "El SKU del balanceador de carga (por ejemplo, 'Basic' o 'Standard')."
  type        = string
}

variable "public_ip_name" {
  description = "El nombre de la configuración de la IP pública asociada al balanceador de carga."
  type        = string
}

variable "public_ip_address_id" {
  description = "El ID de la dirección IP pública que se asociará con el balanceador de carga."
  type        = string
}
