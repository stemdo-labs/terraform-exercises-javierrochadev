# Ejercicio 08

## Objetivos

- Configurar almacenamiento de estado remoto en Azure Blob Storage.

## Pre-requisitos

- Tener una cuenta de almacenamiento en Azure con un contenedor creado.

## Enunciado

Toma como base uno de los módulos desarrollados en ejercicios anteriores y configura el almacenamiento de estado remoto para Terraform en Azure Blob Storage.

Documenta los pasos necesarios para llevar a cabo el proceso con una breve explicación (en una línea) de cada uno; desde los cambios necesarios en azure, si los hubiera, hasta el resultado final tras la destrucción de la infraestructura.

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).


##### Creación de cuenta de almacenamiento y de contendor

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

# Uso de modulo para generar un número aleatorio

resource "random_integer" "random_no"{
  min = 10000
  max = 99999
}

# Generación de la cuenta de almacenamiento

resource "azurerm_storage_account" "my_account"{
  name                     = "${lower(var.account_name)}${random_integer.random_no.result}"
  resource_group_name      = var.existent_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Creación de contenedor

resource "azurerm_storage_container" "my_container"{
  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.my_account.name
  container_access_type = "private"
}

# Generación de token

data "azurerm_storage_account_sas" "sas" {
  connection_string = azurerm_storage_account.my_account.primary_connection_string
  https_only        = true
  # signed_version    = "2017-07-29"

  resource_types {
    service   = true
    container = false
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "1700h") # Expricación alrrededor de 2 años

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}
# Recurso para subir poder escribir información en un fichero

resource "local_file" "post-config"{
  depends_on = [azurerm_storage_container.my_container]
  filename = "${path.module}/backend-config.txt"
  content = <<EOF
storage_account_name = "${azurerm_storage_account.my_account.name}"
container_name = "terraform-state"
key = "terraform.tfstate"
sas_token = "${data.azurerm_storage_account_sas.sas.sas}"

  EOF
}
```

![image](https://github.com/user-attachments/assets/f51b1ec7-006a-435d-b88d-a6632a011e45)

##### Iniciar el proyecto terrafrom 

Para ello seteamos los valores del fihceor de configuración de backend creado anteriormente a la hora de iniciar el proyecto 

```bash
terraform init -config-backend=config-backend.txt
```

Con esto podremos migrar la configuración de nuestro backend en la nube.


