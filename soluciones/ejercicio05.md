# Ejercicio 05

## Objetivos

- Introducción a la utilización de módulos.
- Importación de módulos locales.

## Pre-requisitos

- Haber completado el ejercicio 04.

## Enlaces de Interés

- [Uso de source en bloques de tipo Module](https://developer.hashicorp.com/terraform/language/modules/sources).

## Enunciado

Utilizando el contenido desarrollado durante los ejercicios anteriores, crea un módulo de terraform siguiendo la estructura recomendada por HashiCorp.

Una vez hecho esto, procede con los siguientes pasos:

Crea un nuevo módulo que disponga de un fichero `main.tf`. Añade también un fichero `variables.tf` para definir las variables de entrada, un fichero `outputs.tf` para definir las salidas y un fichero `terraform.tfvars` para definir los valores de las variables de entrada (reutiliza los valores del `ejercicio04`). Este módulo debe utilizar el módulo creado en el proceso anterior, que aún debe estar en local.

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).

Un modulo es un apartado concreto de codigo que puede ser reutilizable por eso se separa del resto de la lógica para poder reutilizarlo, en este caso solo estamos creando el recurso, le tenemos que pasar las variables desde el fichero de variables principal haciendo referencia a las variables que necesita el modulo, lo que va a suceder es que las machaca, por eso la tenemos que definir en vacias.


##### Contenido del module/main

```yaml
resource "azurerm_virtual_network" "v_net" {
    name                     = var.vnet_name
    resource_group_name      = var.existent_resource_group_name
    location                 = var.location
    address_space            = var.vnet_address_space
    tags = {
      "owner_tag" = lookup(var.vnet_tags, "owner_tag", var.owner_tag)
      "environment_tag" = lookup(var.vnet_tags, "environment_tag", var.environment_tag)
    }
}
```

##### Contenido del module/variables

```yaml

variable "location" {

}

variable "existent_resource_group_name" {
 
}

variable "vnet_name" {

}

variable "vnet_address_space" {

}

variable "owner_tag" {

}

variable "environment_tag" {

}

variable "vnet_tags" {

}
```

##### Contenido del main.tf

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
  source                        = "./modules/vnet"
  vnet_name                     = var.vnet_name
  existent_resource_group_name  = var.existent_resource_group_name
  location                      = var.location
  vnet_address_space            = var.vnet_address_space
  owner_tag                     = var.owner_tag
  environment_tag               = var.environment_tag
  vnet_tags                     = var.vnet_tags

}
```

##### Contenido de variables.tf

```yaml
variable "subscription_id" {
  description = "Id de la subscription"
  default     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "tenant_id" {
  description = "Id de la tenant"
  default     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}


variable "location" {
  description = "Localización del grupo de recursos"
  default     = "West Europe"
}

variable "existent_resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la red"
  type        = string
  validation {
    condition     = var.vnet_name != "" && var.vnet_name != null
    error_message = "vnet_name no puede ser una cadena vacía."
  }
}

variable "vnet_address_space" {
  description = "Direccion de la red"
  type        = list(string)
}

variable "owner_tag" {
  description = "Describe el propietario de la VNet."
  type        = string
  validation {
    condition     = var.owner_tag != "" && var.owner_tag != null
    error_message = "owner_tag no puede ser una cadena vacía."
  }
}

locals{
    allowed_envs = ["DEV", "PRO", "TES", "PRE"]
}

variable "environment_tag" {
  description = "Describe el entorno de la VNet (dev, test, prod, etc)."
  type        = string
  validation {
    condition     = var.environment_tag != "" && var.environment_tag != null
    error_message = "environment_tag no puede ser una cadena vacía."
  }
   validation {
    condition = contains(local.allowed_envs, upper(var.environment_tag))
    error_message = "El environment tiene que ser uno de estos valores --> [DEV, PRO, TES, PRE]"
  }

  
}

variable "vnet_tags" {
  description = "Describe los tags adicionales que se aplicarán a la VNet."
  type        = map(string)
  default     = {
    "owner_tag" = "es un owner tag"
  }
  validation {
    condition     = length(var.vnet_tags) > 0
    error_message = "vnet_tags no puede ser un mapa vacío."
  }
   validation {
    condition     = alltrue([for vnet_tag in var.vnet_tags : vnet_tag != "" && vnet_tag != null])
    error_message = "Los valores de vnet_tags no pueden estar vacios."
  }
  
  
}
```

##### Demostración

```bash
terraform plan
```

![image](https://github.com/user-attachments/assets/e6344880-c039-4072-86b2-c35591615a25)


