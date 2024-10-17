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

resource "azurerm_storage_account" "tfaccount" {
  name                     = "vaultaccount"
  resource_group_name      = var.existent_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"                  
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
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


Ahora verificamos en el portal Azure que la cuenta y el vault se han creado corretamente.

![image](https://github.com/user-attachments/assets/f089eca0-7c21-4e6e-b2f8-d713dbdfb3cb)


##### Imoprtación desde otra carpeta

Definimos los mismo resursos que hay en el otro poryecto de terraform parapoder traernos la condifguración de los recursos mediante import.

```hcl
import {
  to = azurerm_storage_account.vaultaccount
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

![image](https://github.com/user-attachments/assets/86ee2f7c-82cd-402c-85cd-d291612de361)

Tenemos que cambiar ciertos valores geenerados en el generated.tf con el valor de 7 que tenemos por defecto en el despligue con el TF!.

## 1. Revisa el código. ¿Qué observas? ¿El código generado es exactamente lo que esperabas?

Se ha generado un archivo generated.tf en el cual aparce los recursos con los datos que tienen realmente en la nube.

## 2. ¿Qué sucede cuando ejecutas la creación de un recurso que ya existe en Azure pero no está reflejado en el archivo de configuración de Terraform?

Da error de duplicidad, es decir, como ya existe, no puede volver a crearlo. Por eso se hace uso del import de los recursos que ya hay en la nube. Estos se guardan en el generated.tf, lo cual te permite saber lo que hay en la nube y generar en el archivo main la nueva configuración a partir de esa. Así no hay conflictos, ya que lo que hace Terraform es unificar todos los archivos .tf y de ahí forma toda la configuración.

### Segunda parte

##### Eliminación de key_vault

Para borrar un recurso de manera rápida usaremos el destroy poniendo una bandera como target al recurso que queremos borrar.

```bash
terraform destroy -target=azurerm_key_vault.keyvault
```

Podemos observar como en Azure esta borrado el key vault pero sin embargo la cuenta de almacenamiento sigue presente, justo lo que queriamos.

![image](https://github.com/user-attachments/assets/348bcc30-92e7-4e0a-be1b-77529da6e773)

Generamos una copia del archivo del estado de TF1.

![image](https://github.com/user-attachments/assets/e5efdf84-49e5-40ab-b773-4f1f4c7c34b2)

Para poder borrar del tfstate el modulo recurso específico que genera el key vault podemos usar el siguiente comando, lo que hace es eliminar manualmente un recurso, asi terraform no lo tendra en cuenta por que al no estar en su state es como si no existiera.

Podemos mostrar todos los recursos que tenemos con este comando.

```bash
terraform state list
```

![image](https://github.com/user-attachments/assets/e54c8aa1-7c80-4242-9504-4b84ab6f30a1)

```bash
terraform state rm azurerm_key_vault.tf1-key-vault
```

![image](https://github.com/user-attachments/assets/650b9a32-ddba-4dd3-a456-c07d8c8da777)

Ahora para reflejar los cambios reales debemos de borrar el import que hace referncia al akv ya que no esta desplegado, al borrarlo de nuesto state a mano no nos dara problemas, borramos el archivo generated.tf y volvemos a hacer un plan pero esta vez solo con el impor de la cuenta de almacenamiento.

Por otro lado tambien debemos de eliminarlo del archivo generated.tf ya que tiene todos los recursos desplegados en la nube de azure. 

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

import {
  to = azurerm_storage_account.tfacc
  id = "/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868/resourceGroups/rg-jrocha-dvfinlab/providers/Microsoft.Storage/storageAccounts/tf1acc"
}
```

![image](https://github.com/user-attachments/assets/ab69ab28-972b-4d52-9a00-bf2fc2c0511e)


Podemos observar como se ha realizado un cambio sobre el archivo existente es decir no ha habido ningun problema por que borramos el archivo que no existe en nuestro state local.

![Uploading image.png…]()



## 1. ¿Qué diferencias observas entre el backup del tfstate de TF2 y el resultado de aplicar las operaciones previas?
## 2. ¿Qué problemática podrías enfrentar en el tfstate de un Terraform si un recurso de su configuración es eliminado manualmente (sin usar ese Terraform)?
## 3. ¿Qué maneras se te ocurren para comprobar que el tfstate refleja el estado real de los recursos?
## 4. ¿Es necesario mantener los bloques de importación en el archivo main.tf de TF2 después de realizar las operaciones anteriores?



