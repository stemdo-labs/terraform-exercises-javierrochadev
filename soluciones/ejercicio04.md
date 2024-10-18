# Ejercicio 04

## Objetivos

- Practicar la validación de variables en módulos de Terraform.
- Combinar el uso de funciones de terraform.
- Introducción opcional al uso de expresiones regulares como herramienta para validación.

## Enlaces de Interés

- [Funciones de Terraform](https://developer.hashicorp.com/terraform/language/functions)
- [terraform console](https://developer.hashicorp.com/terraform/cli/commands/console)
- [Expresiones en Terraform](https://developer.hashicorp.com/terraform/language/expressions)

## Enunciado

Modifica el ejercicio anterior para que se cumplan las siguientes condiciones:

- `owner_tag`,`environment_tag` y `vnet_name` no pueden ser cadenas vacías ni ***nullable***.
- En `environment_tags`, los valores de los tags solo pueden contener uno de los siguientes valores, sin tener en cuenta mayúsculas o minúsculas (es decir, tanto 'dev', como 'DEv', como 'DEV' son valores aceptados): 'DEV', 'PRO', 'TES', 'PRE'.<br/>**Consejo:** Utiliza la función `contains` de Terraform en combinación con otras.
- `vnet_tags` no pueder null y además ninguno de los valores del mapa puede ser null o cadena vacía. 

Se debe elegir una de las siguientes opciones para validar la variable `vnet_name`:

### Opción 1 (Menor dificultad)

Debe cumplirse que comience siempre por `vnet`.

### Opción 2 (Mayor dificultad)

**Nota**: Esta opción está ideada para el uso de expresiones regulares.

Debe cumplirse que comience por `vnet` seguido de más de dos caracteres contenidos en el rango `[a-z]` y que termine por `tfexercise` seguido de al menos dos dígitos numéricos. Algunos ejemplos de valores aceptados y no aceptados serían:
  - `vnetprodrigueztfexercise01` -> Aceptado.
  - `vnetprodrigueztfexercise` -> No aceptado.
  - `vnetprodrigueztfexercise1` -> No aceptado.
  - `vnetpr0drigu3ztfexercise01` -> No aceptado.
  - `vnetprodrigueztfexercises01` -> No aceptado.
  - `vetprodrigueztfexercise01` -> No aceptado.
  - `vnetProdrigueztfexercise01` -> No aceptado.

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).

##### Contenido de archivo main.tf

Es el mismo contenido  que en el ejericicio anterior.

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

##### Contenido del archivo variables.tf

```yaml
variable "subscription_id" {
  description = "Id de la subscription"
  default     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "tenant_id" {
  description = "Id de la tenant"
  default     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
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
# Opción fácil
  validation {
    condition     = var.vnet_name != "" && var.vnet_name != null
    error_message = "vnet_name no puede ser una cadena vacía."
  }
# Opción dificil

 validation {
    condition     = can(regex("^vnet[a-z]{2,}tfexercise\\d{2,}$", var.vnet_name))
    error_message = "El nombre debe comenzar con 'vnet', seguido de al menos dos letras minúsculas, luego 'tfexercise', y terminar con al menos dos dígitos."
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
    "owner_tag" = "wetrhth4"
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

1. **condition**
   - **Descripción**: La clave `condition` se utiliza para definir la condición que debe cumplirse para que el valor de la variable sea considerado válido. Si la condición no se cumple, se mostrará un mensaje de error definido en `error_message`.
   - **Uso**: Se utiliza en todas las validaciones y permite especificar cualquier expresión booleana, lo que facilita el control de las entradas del usuario.

2. **error_message**
   - **Descripción**: Este campo permite definir un mensaje de error que se mostrará si la condición de validación no se cumple. Es útil para guiar al usuario sobre lo que se necesita corregir.
   - **Uso**: Se utiliza junto con `condition` para proporcionar retroalimentación clara y específica sobre los errores de entrada.

3. **length()**
   - **Descripción**: Esta función devuelve la longitud (número de elementos) de una lista, conjunto o mapa. Se usa para verificar si una colección tiene elementos.
   - **Uso**: Ayuda a garantizar que una variable que se espera que contenga varios elementos no esté vacía, como en el caso de mapas o listas.

4. **alltrue()**
   - **Descripción**: Esta función evalúa una lista de condiciones y devuelve `true` solo si todas las condiciones son verdaderas. Se utiliza para validar que todos los elementos de una colección cumplan con un criterio específico.
   - **Uso**: Es útil cuando se necesita asegurar que un conjunto de elementos (como las etiquetas en un mapa) cumplan con una condición, como no estar vacíos o no ser `null`.

5. **contains()**
   - **Descripción**: Esta función verifica si un elemento específico está presente en una lista. Devuelve `true` si el elemento se encuentra en la lista y `false` si no.
   - **Uso**: Se utiliza para validar que un valor proporcionado por el usuario se encuentre dentro de un conjunto predefinido de valores permitidos, garantizando así que la entrada sea válida en el contexto de la aplicación.

6. **upper()**
   - **Descripción**: Esta función convierte una cadena a mayúsculas. Es útil para normalizar las entradas antes de realizar comparaciones.
   - **Uso**: Se utiliza comúnmente en validaciones para asegurar que las entradas sean comparables, independientemente de cómo el usuario ingrese el texto (en mayúsculas o minúsculas).
  
7. **regex()**
   - **Descripción**: Esta función evalúa una cadena de texto contra una expresión regular y devuelve `true` si hay coincidencia o `false` si no la hay. Es útil para validar formatos y patrones en cadenas de texto.
   - **Uso**: Se utiliza comúnmente en validaciones para comprobar si una variable o entrada de usuario cumple con un formato específico. En este caso, se aplica para verificar si el valor de `var.vnet_name` coincide con el patrón definido por la expresión regular `^vnet[a-z]{2,}tfexercise\\d{2,}$`. Esto asegura que el nombre de la red virtual siga las reglas establecidas, como comenzar con "vnet", estar seguido de al menos dos letras minúsculas, incluir "tfexercise", y terminar con al menos dos dígitos numéricos.

8. **can()**
   - **Descripción**: Esta función evalúa una expresión y devuelve `true` si la expresión se ejecuta correctamente, o `false` si ocurre un error. Es útil para manejar excepciones de forma segura en Terraform.
   - **Uso**: Se utiliza comúnmente para verificar si una operación, como una expresión regular, puede ejecutarse sin errores. En este caso, se emplea junto con la función `regex()` para comprobar si el valor de la variable `var.vnet_name` cumple con un patrón específico. Esto permite asegurar que la variable contenga un formato válido antes de proceder con otras operaciones, garantizando así la integridad de los datos.



##### Casos de uso

1. Cuando dejamos environment_tag y owner_tag vacios

![image](https://github.com/user-attachments/assets/20e5f655-e26e-48e4-87c0-f5fccf719f33)

2. Valor en minúscula de environment_tag

![image](https://github.com/user-attachments/assets/6f5b8fe4-17a3-45e9-a75d-181585ea7fb9)

3. Valores vacios para algun valor de vnet_tags

![image](https://github.com/user-attachments/assets/351259e9-6f33-4107-b8dd-61adecb2468a)

![image](https://github.com/user-attachments/assets/025e5606-7e7c-400a-a2db-c49e61ede1d6)

4. El vnet_tags esta vacio

![image](https://github.com/user-attachments/assets/2a1faee9-ed06-457f-ae54-381f5cee56d0)

![image](https://github.com/user-attachments/assets/18390fce-6e7a-42ce-bafe-ee737360abc2)







   

