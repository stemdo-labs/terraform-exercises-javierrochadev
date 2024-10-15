# Ejercicio 06

## Objetivos

- Introducción a la utilización de módulos remotos.

## Pre-requisitos

- Haber completado el ejercicio05.

## Enlaces de Interés

- [Uso de source en bloques de tipo Module](https://developer.hashicorp.com/terraform/language/modules/sources).

## Enunciado

Sube el módulo creado en el ejercicio anterior a un repositorio de GitHub (si se han seguido las instrucciones, ya debería estar localizado en la entrega del ejercicio previo).

Crea un nuevo fichero `main.tf` que haga uso del módulo localizado en el repositorio remoto.

Añade también un fichero `variables.tf` para definir las variables de entrada del módulo, un fichero `outputs.tf` para definir las salidas del módulo y un fichero `terraform.tfvars` para definir los valores de las variables de entrada (reutiliza todo lo que sea posible del ejercicio anterior).

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).

Para usar un modulo remoto primero debemos de conocer en que plataforma esta este archivo alojado, y esque terraform es capaz de distinguir la plataforma de alojamiento del modulo para realizar la descarga de este de manera mas accesible para el usuario, por ejemplo es capaz de abrir el navegador para pedirnos a modo de click la autenticación para poder usar ese modulo, tambien podemos almacenarlo en un repo público para poder usarlo sin problemas de autenticación.

##### Contenido de main.tf

```yaml
terraform {
  required_version = ">= 0.12"
  required_providers{
   azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}

module "vnet" {
  existent_resource_group_name  = var.existent_resource_group_name
  location                      = var.location
  vnet_address_space            = var.vnet_address_space
  owner_tag                     = var.owner_tag
  environment_tag               = var.environment_tag
  vnet_tags                     = var.vnet_tags

}
```

##### Contenido del ouputs.tf

```yaml
output "vnet_name" {
  description = "El nombre de la red virtual creada"
  value       = azurerm_virtual_network.v_net.name
}
```

```bash
terraform init
```

![image](https://github.com/user-attachments/assets/bb2a946b-046e-4a9f-af4e-853b23e2f331)

```bash
terraform plan
```

![image](https://github.com/user-attachments/assets/9eee5d4a-e2e5-4f87-9d61-48afa4c840ab)









