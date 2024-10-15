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

##### Contenido del main 

Vamos a usar el recurso azurerm_virtual_network propio de Azure para la creación de redes son las variables que necesita para su fucnión como es el caso de una dirección IP


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
}
```

##### Contenido de terraform.tfvars

Genramos umn fichero que usaremos a modo de variables de entorno con los valores que necesitamos los cuales son fijos


```yaml
existent_resource_group_name = "rg-jrocha-dvfinlab"
vnet_name = "vnetjaviertfexercise01"
vnet_address_space = ["10.0.0.0/16"]
```

###### Contenido de variables.tf

Generamos un fichero de variables donde no damos valor a las variables que tenemos definidas en el fichero tfvars, si que le damos los valores al subscription_id y tenant_id, y tambien por petición del enunciado a la variable de location.

```yaml
variable "subscription_id" {
  description = "Id de la subscription"
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "tenant_id" {
  description = "Id de la tenant"
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "location" {
  description = "Localización del grupo de recursos"
  default = "West Europe"
}

variable "existent_resource_group_name" {
  description = "Nombre del grupo de recursos"
  type = string
}

variable "vnet_name" {
  description = "Nombre de la red"
  type = string
}

variable "vnet_address_space" {
  description = "Direccion de la red"
  type = list(string)
}
```

##### Creación y subida del recurso a Azure

```bash
terraform init
```

![image](https://github.com/user-attachments/assets/fd24e059-654e-4a18-b997-43582177078a)


```bash
terraform plan
```

![image](https://github.com/user-attachments/assets/04d75b6e-accb-4694-9b15-68e3df6d4f00)

```bash
terraform apply
```
![image](https://github.com/user-attachments/assets/614198ed-2d3c-4546-9997-fa464c02e9c1)

![image](https://github.com/user-attachments/assets/cbc30435-a98a-4781-9599-cb8406a2b4a5)

![image](https://github.com/user-attachments/assets/35c3fdb3-e25b-44bc-bd29-ba5a8c1d5f8a)




