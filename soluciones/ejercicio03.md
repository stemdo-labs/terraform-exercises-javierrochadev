# Ejercicio 03

## Objetivos

- Introducción al uso de funciones de terraform.
- Avanzar en la parametrización de módulos, profundizando en los tipos de variables y su uso para estandarizar requisitos en la configuración de infraestructura (a través de la inclusión de tags obligatorias y adicionales).

## Enlaces de Interés

- [Funciones de Terraform](https://developer.hashicorp.com/terraform/language/functions)
- Se puede hacer uso del comando [terraform console](https://developer.hashicorp.com/terraform/cli/commands/console) para probar funciones y expresiones.

## Enunciado

Modifica el ejercicio anterior e incluye tres nuevas variables:

- `owner_tag`:
  - Tipo: `string`
  - Obligatoria.
  - Describe el propietario de la VNet.
- `environment_tag`:
  - Tipo: `string`
  - Obligatoria.
  - Describe el entorno de la VNet (`dev`, `test`, `prod`, etc).
- `vnet_tags`:
  - Tipo: `mapa de strings`
  - Opcional, siendo su valor por defecto un mapa vacío.
  - Describe los tags adicionales que se aplicarán a la VNet.

El módulo debe utilizar estas variables para formar los tags de la VNet, incluyendo los tags obligatorios `owner` y `environment` y los tags adicionales que se especifiquen en `vnet_tags`. Si en `vnet_tags` se especifica un tag con el mismo nombre que `owner` o `environment`, se debe sobreescribir el valor de estos últimos por el valor de `vnet_tags`.

Despliega el recurso en Azure utilizando el módulo desarrollado, documentando el proceso en el entregable.

## Entregables



**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).

##### Contenido de main.tf

Tenemos como nuevo valor el uso de la variable tags que tiene definida el módulo azurerm_virtual_network, la cual acepta un map de string para poder indicarle las etiquetas que quieras. Hacemos el uso de la función lookup(map_name, "key_on_search", "default_value"), la cual busca en un mapa una variable que tenga la clave especificada en el primer parámetro y le asigna un valor por defecto si esta no existe en dicho mapa.

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

output "instance_tags" {
  description = "Tags de la red v_net"
  value       = azurerm_virtual_network.v_net.tags
}
```


##### Contenido del fichero de varibales.tf

```yaml
variable "subscription_id" {
  description = "Id de la subscription"
  default     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
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
}

variable "vnet_address_space" {
  description = "Direccion de la red"
  type        = list(string)
}

variable "owner_tag" {
  description = "Describe el propietario de la VNet."
  type        = string
}

variable "environment_tag" {
  description = "Describe el entorno de la VNet (dev, test, prod, etc)."
  type        = string
  
}

variable "vnet_tags" {
  description = "Describe los tags adicionales que se aplicarán a la VNet."
  type        = map(string)
  default     = {}
}
```

##### Creación y subida del recurso 

```bash
terraform init
```

![image](https://github.com/user-attachments/assets/2c718829-a47d-4669-987d-47f656a9d2d7)

##### Prueba con un mapa vacio para ver las etiquetas

```bash
terraform plan
```
![image](https://github.com/user-attachments/assets/9148e9b7-b3eb-435f-a72e-95164c7d4dea)

![image](https://github.com/user-attachments/assets/d02f6083-670e-4a2f-80e9-e4f8383b3172)

##### Prueba con un mapa con valores para las etiquetas iguales que las existentes

```bash
terraform plan
```

![image](https://github.com/user-attachments/assets/418f5e27-452d-421d-9732-3a1eca0a339b)

![image](https://github.com/user-attachments/assets/a205751a-f863-478f-bc3b-f095f971577b)








