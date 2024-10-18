variable "subnets" {
  description = "Estas son las direcciones de las subredes"

  type = list(object({
    name             = string
    ip = list(string)
  }))
  
}
 

   variable "resource_group_name"  {
    description = "Nombre del grupo de recursos."
    type       = string
  }    

   variable "virtual_network_name"  {
    description = "Nombre de la red virtual"
    type       = string
  }    

