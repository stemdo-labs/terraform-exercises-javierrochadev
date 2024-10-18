variable "lb_probe_name" {
  description = "El nombre del sondeador del balanceador de cargas"
  type        = string
}

variable "loadbalancer_id" {
  description = "El nid del balanceador de cargas"
  type        = string
}

 
variable "port"  {
    description = "Puerto de escucha"
    type       = string
  }     

