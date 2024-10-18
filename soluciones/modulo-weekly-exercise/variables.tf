  variable "subscription_id" {
  description = "Id de la subscription"
  default     = "86f76907-b9d5-46fa-a39d-aff8432a1868"
}

variable "tenant_id" {
  description = "Id de la tenant"
  default     = "2835cee8-01b5-4561-b27c-2027631bcfe1"
}

  
  variable "location"  {
    description = "Localización de la infraestructura"
    type        = string
    default     = "West Europe"
  }    

    variable "resource_group_name"  {
    description = "Localización de la infraestructura"
    type        = string
    default     = "rg-jrocha-dvfinlab"
  }        
  variable "subnets" {
  type = list(object({
    name             = string
    ip = list(string)
  }))
  
  description = "Estas son las direcciones de las subredes"
  
  default = [
    {
      name             = "subred_1"
      ip = ["10.0.1.0/24"]
    },
    {
      name             = "subred_2"
      ip = ["10.0.2.0/24"]
    },
    {
      name             = "subred_3"
      ip = ["10.0.3.0/24"]
    },
    {
      name             = "subred_4"
      ip = ["10.0.4.0/24"]
    }
  ]
  }



 variable "network_security_group_name"  {
    description = "Nombre del grupo de seguridad."
    type        = string
    default     = "main-sec-group"
  }  

