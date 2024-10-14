# Ejercicio 02

## Objetivo

- Parametrizar un módulo raíz básico de Terraform.
- Introducción al uso de bloques "data" en Terraform.

## Pre-requisitos

- Disponer de un `resource group` en Azure sobre el que poder desplegar los recursos de este ejercicio.

## Enunciado

Desarrolla un módulo de terraform que permita desplegar una Virtual Network (VNet) sobre un Resource Group pre-existente en Azure. Para esto, crea los ficheros:

- `main.tf`, para los recursos terraform.
- `variables.tf`, para la definición de las variables de entrada.
- `terraform.tfvars`, para los valores de las variables de entrada.

El módulo debe contener una parametrización adecuada para aceptar el contenido del siguiente fichero `terraform.tfvars` (adapta los valores entre los símbolos `< >`):

```hcl
existent_resource_group_name = "<nombre_de_un_rg_ya_existente>"
vnet_name = "vnet<tunombre>tfexercise01"
vnet_address_space = ["10.0.0.0/16"]
```

Además debe existir una variable adicional, `location`, que permita indicar la localización donde se desplegará la VNet. Si no se especifica su valor en el tfvars, se debe utilizar `West Europe` por defecto.

Despliega el recurso en Azure utilizando el módulo desarrollado, documentando el proceso en el entregable.

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).