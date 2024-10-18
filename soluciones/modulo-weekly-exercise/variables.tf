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

