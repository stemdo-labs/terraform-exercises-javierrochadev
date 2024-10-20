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

variable "account_name"{
  description = "Es el nombre de la cuenta de almacenamiento"
  type = string
  default = "stajrochadvfinlab"
}

