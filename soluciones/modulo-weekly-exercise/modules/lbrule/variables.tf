

variable "loadbalancer_id" {
  description = "The ID of the load balancer where the rule will be created."
  type        = string
}

variable "rule_name" {
  description = "The name of the load balancer rule."
  type        = string
}

variable "rule_protocol" {
  description = "The protocol for the load balancer rule (e.g., Tcp, Udp)."
  type        = string
}

variable "frontend_port" {
  description = "The port number for frontend communication."
  type        = number
}
variable "backend_port" {
  description = "The port number for backend communication."
  type        = number
}

variable "public_ip_name" {
  description = "The name of the frontend IP configuration (typically a public IP) associated with the load balancer."
  type        = string
}

variable "probe_id" {
  description = "The ID of the probe used to check the health of the backend instances."
  type        = string
}

variable "backend_address_pool_ids" {
  description = "The list of backend address pool IDs to which the rule will send traffic."
  type        = list(string)
}
