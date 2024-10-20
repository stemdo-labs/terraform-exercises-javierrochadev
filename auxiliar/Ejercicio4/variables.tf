variable "subscription_id" {
  description = "Id de la subscription"
  default     = "86f76907-b9d5-46fa-a39d-aff8432a1868"
}

variable "tenant_id" {
  description = "Id de la tenant"
  default     = "2835cee8-01b5-4561-b27c-2027631bcfe1"
}


variable "location" {
  description = "Localización del grupo de recursos"
  default     = "West Europe"
}

variable "existent_resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la red"
  type        = string
  validation {
    condition     = var.vnet_name != "" && var.vnet_name != null
    error_message = "vnet_name no puede ser una cadena vacía."
  }
  validation {
    condition     = can(regex("^vnet[a-z]{2,}tfexercise\\d{2,}$", var.vnet_name))
    error_message = "El nombre debe comenzar con 'vnet', seguido de al menos dos letras minúsculas, luego 'tfexercise', y terminar con al menos dos dígitos."
  }
}

variable "vnet_address_space" {
  description = "Direccion de la red"
  type        = list(string)
}

variable "owner_tag" {
  description = "Describe el propietario de la VNet."
  type        = string
  validation {
    condition     = var.owner_tag != "" && var.owner_tag != null
    error_message = "owner_tag no puede ser una cadena vacía."
  }
}

locals{
    allowed_envs = ["DEV", "PRO", "TES", "PRE"]
}

variable "environment_tag" {
  description = "Describe el entorno de la VNet (dev, test, prod, etc)."
  type        = string
  validation {
    condition     = var.environment_tag != "" && var.environment_tag != null
    error_message = "environment_tag no puede ser una cadena vacía."
  }
   validation {
    condition = contains(local.allowed_envs, upper(var.environment_tag))
    error_message = "El environment tiene que ser uno de estos valores --> [DEV, PRO, TES, PRE]"
  }

  
}

variable "vnet_tags" {
  description = "Describe los tags adicionales que se aplicarán a la VNet."
  type        = map(string)
  default     = {
    "owner_tag" = "es un owner tag"
  }
  validation {
    condition     = length(var.vnet_tags) > 0
    error_message = "vnet_tags no puede ser un mapa vacío."
  }
   validation {
    condition     = alltrue([for vnet_tag in var.vnet_tags : vnet_tag != "" && vnet_tag != null])
    error_message = "Los valores de vnet_tags no pueden estar vacios."
  }
  
  
}


variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  description = "Estas con las direcciones de las subredes"
  default = [
  {
    name             = "subred_1"
    address_prefixes = ["10.0.0.0/17"]
  },
  {
    name             = "subred_2"
    address_prefixes = ["10.0.128.0/17"]
  }
]

}

variable "account_name"{
  description = "Es el nombre de la cuenta de almacenamiento"
  default = "stajrochadvfinlab"
}