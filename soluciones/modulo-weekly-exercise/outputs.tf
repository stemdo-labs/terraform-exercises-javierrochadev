
output "public_ip_address" {
  description = "La dirección ip de la ip púbilca creada"
  value = "http://${module.public-ip.public_ip_address}"
}