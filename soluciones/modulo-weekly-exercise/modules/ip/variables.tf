variable "name" {
  description = "Nombre para la dirección IP pública"
  type        = string
}

variable "location" {
  description = "Ubicación de los recursos en Azure"
  type        = string
  default     = "East US"  # Puedes establecer un valor por defecto si lo deseas
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos de Azure donde se crearán los recursos"
  type        = string
}

variable "allocation_method" {
  description = "Método de asignación para la IP pública (Static o Dynamic)"
  type        = string
  default     = "Static"
}

variable "sku" {
  description = "SKU de la IP pública (Standard o Basic)"
  type        = string
}


