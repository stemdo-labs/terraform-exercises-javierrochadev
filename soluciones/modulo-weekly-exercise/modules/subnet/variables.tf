variable "subnets" {
  type = list(object({
    name             = string
    ip = list(string)
  }))
  
  description = "Estas son las direcciones de las subredes"
}

 
variable "resource_group_name"  {
    description = "Nombre del grupo de recursos."
    type       = string
  } 
 
 

   variable "virtual_network_name"  {
    description = "Nombre de la red virtual"
    type       = string
  }    

