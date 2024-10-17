## Respuestas para las preguntas del ejerccio 09

##### Creación de los resursos

Creamos los dos recursos que se espefican en el enunciado con los nombres que se ven a continuación.


```hcl
terraform {
  required_version = ">= 0.12"
  required_providers{
   azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
  
    # backend "azurerm"{
    #   storage_account_name = "stajrochadvfinlab"
    #   container_name       = "terraform-state"
    #   key                  = "terraform.tfstate"
    #   resource_group_name  = "rg-jrocha-dvfinlab"
    # }

}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}

resource "azurerm_storage_account" "tf1" {
  name                     = var.account_name 
  resource_group_name      = var.existent_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"                  
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                        = "tf1-key-vault"
  location                    = var.location
  resource_group_name         = var.existent_resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
```

![image](https://github.com/user-attachments/assets/d76f7fa2-9ccc-4636-893b-91a0aebefb56)

Ahora verificamos en el portal Azure que la cuenta y el vault se han creado corretamente.

![image](https://github.com/user-attachments/assets/59328d85-ee6b-4377-8a54-11f98189ed54)


##### Imoprtación desde otra carpeta

Definimos los mismo resursos que hay en el otro poryecto de terraform parapoder traernos la condifguración de los recursos mediante import.

```hcl
import {
  to = azurerm_storage_account.tfacc
  id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

import {
  to = azurerm_key_vault.tf1-key-vault
  id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

```bash
terraform plan -generate-config-out=generated.tf
```

Podemos ver como nos crea el archivo generated.tf con el código de los recursos desplegados en la nube.

![image](https://github.com/user-attachments/assets/5f1fba4b-d5ac-4ec8-aa65-5f5b08676435)

Tenemos que cambiar ciertos valores geenerados en el generated.tf con el valor de 7 que tenemos por defecto en el despligue con el TF!.

## 1. Revisa el código. ¿Qué observas? ¿El código generado es exactamente lo que esperabas?

Se ha generado un archivo generated.tf en el cual aparce los recursos con los datos que tienen realmente en la nube.

## 2. ¿Qué sucede cuando ejecutas la creación de un recurso que ya existe en Azure pero no está reflejado en el archivo de configuración de Terraform?

Da error de duplicidad, es decir, como ya existe, no puede volver a crearlo. Por eso se hace uso del import de los recursos que ya hay en la nube. Estos se guardan en el generated.tf, lo cual te permite saber lo que hay en la nube y generar en el archivo main la nueva configuración a partir de esa. Así no hay conflictos, ya que lo que hace Terraform es unificar todos los archivos .tf y de ahí forma toda la configuración.

### Segunda parte

##### Eliminación de key_vault

Para borrar un recurso de manera rápida usaremos el destroy poniendo una bandera como target al recurso que queremos borrar.

```bash
terraform destroy -target=azurerm_key_vault.example
```





