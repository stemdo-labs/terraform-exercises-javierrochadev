  variable "subscription_id" {
  description = "Id de la subscription"
  type = string
}

variable "tenant_id" {
  description = "Id de la tenant"
  type = string
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
    # {
    #   name             = "subred_3"
    #   ip = ["10.0.3.0/24"]
    # },
    # {
    #   name             = "subred_4"
    #   ip = ["10.0.4.0/24"]
    # }
  ]
  }



variable "network_security_group_name"  {

    description = "Nombre del grupo de seguridad."
    type        = string
    default     = "main-sec-group"
  }  

variable "public_ip_name"  {

    description = "Nombre de la IP púbilca."
    type        = string
    default     = "test-ip"
  }  

variable "network_interface_name"  {

    description = "Nombre de la IP púbilca."
    type        = string
    default     = "test-interface"
  }

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

  default = [
    {
      name                      = "test-vm1"
      size                      = "Standard_B1s" # VM barata para pruebas
      disk_name                 = "test-vm1-disk"
      storage_account_type      = "Standard_LRS" # Tipo de almacenamiento
      username                  = "adminuser"
      password                  = "P@ssw0rd1234!"
    },
    {
      name                      = "test-vm2"
      size                      = "Standard_B1s"
      disk_name                 = "test-vm2-disk"
      storage_account_type      = "Standard_LRS"
      username                  = "adminuser"
      password                  = "P@ssw0rd1234!"
    },
    # {
    #   name                      = "test-vm3"
    #   size                      = "Standard_B1s"
    #   disk_name                 = "test-vm3-disk"
    #   storage_account_type      = "Standard_LRS"
    #   username                  = "adminuser"
    #   password                  = "P@ssw0rd1234!"
    # },
    # {
    #   name                      = "test-vm4"
    #   size                      = "Standard_B1s"
    #   disk_name                 = "test-vm4-disk"
    #   storage_account_type      = "Standard_LRS"
    #   username                  = "adminuser"
    #   password                  = "P@ssw0rd1234!"
    # }
  ]
}
variable "sku" {
  description = "SKU de la IP pública (Standard o Basic)"
  type        = string
  default     = "Standard"
}

variable "load_balancer_name" {
  description = "Nombre para el balanceador de cargas"
  type        = string
  default     = "test-lb"
}

variable "lb_pool_name" {
  description = "Nombre para el grupo de ips del balanceador de cargas"
  type        = string
  default     = "test-lb-pool"
}


# Variables para el probe del balanceador de cargas
variable "lb_probe_name" {
  description = "Nombre para el grupo de ips del sondeador"
  type        = string
  default     = "test-lb-probe"
}
variable "port" {
  description = "Puerto del balanceador de cargas"
  type        = number
  default     = 80
}

# Variables para las reglas del balanceador
variable "rule_name" {
  description = "Nombre de la regla para el balanceador"
  type        = string
  default     = "test-lb-rule"
}
variable "rule_protocol" {
  description = "Protocolo que se va a seguir para el balanceo"
  type        = string
  default     = "Tcp"
}

