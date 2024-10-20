
  
  variable "location"  {
    description = "Localización de la infraestructura"
    type        = string

  }    

  variable "vnet_address_space"  {
    description = "Dirección de la vnet"
    type        = list(string)
     validation {
    condition = length(var.vnet_address_space) > 0
    error_message = "La dirección de la VNet no puede estar vacía. Debe contener al menos una dirección."
  }
  }  

    variable "resource_group_name"  {
    description = "Localización de la infraestructura"
    type        = string
    
  }        
 

locals {
  
  subnets = [
    for i in range(var.vm_count) : {
      name = "subred-test_${i + 1}"
      ip   = ["10.0.${i + 1}.0/24"]
    }
  ]
}

variable "network_security_group_name"  {

    description = "Nombre del grupo de seguridad."
    type        = string
    default     = "main-sec-group-test"
  }  

variable "public_ip_name"  {

    description = "Nombre de la IP púbilca."
    type        = string
    default     = "ip-public-test"
  }  

variable "network_interface_name"  {

    description = "Nombre de la IP púbilca."
    type        = string
    default     = "interface-test"
  }

variable "vm_count" {
  description = "Número de máquinas virtuales a crear."
  type        = number
  validation {
    condition     = var.vm_count >= 1 && var.vm_count <= 3
    error_message = "El número de máquinas virtuales debe estar entre 1 y 3."
  }
}


locals {
  virtual_machines = [
    for i in range(var.vm_count) : {
      name                      = "test-tvm-${i + 1}"
      size                      = "Standard_B1s" # VM barata para pruebas
      disk_name                 = "test-tvm-${i + 1}-disk"
      storage_account_type      = "Standard_LRS" # Tipo de almacenamiento
      username                  = "adminuser"
      password                  = "P@ssw0rd1234!"
    }
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
  default     = "lb-test"
}

variable "lb_pool_name" {
  description = "Nombre para el grupo de ips del balanceador de cargas"
  type        = string
  default     = "lb-pool-test"
}


# Variables para el probe del balanceador de cargas
variable "lb_probe_name" {
  description = "Nombre para el grupo de ips del sondeador"
  type        = string
  default     = "lb-probe-test"
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
  default     = "lb-rule-test"
}
variable "rule_protocol" {
  description = "Protocolo que se va a seguir para el balanceo"
  type        = string
  default     = "Tcp"
}
variable "lb_out_rule_name" {
  description = "Protocolo que se va a seguir para el balanceo"
  type        = string
  default     = "lboutbound-rule-test"
}



