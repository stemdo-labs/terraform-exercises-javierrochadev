## Respuestas para las preguntas del ejerccio 09

##### Creación de los resursos

Creamos los dos recursos que se especifican en el enunciado con los nombres que se ven a continuación.


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


Ahora verificamos en el portal Azure que la cuenta y el vault se han creado correctamente.

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

Para poder borrar del tfstate el módulo o recurso específico que genera el Key Vault, podemos usar el siguiente comando. Lo que hace es eliminar manualmente un recurso, así Terraform no lo tendrá en cuenta, porque al no estar en su state, es como si no existiera.

Podemos mostrar todos los recursos que tenemos con este comando.

```bash
terraform state list
```

![image](https://github.com/user-attachments/assets/e54c8aa1-7c80-4242-9504-4b84ab6f30a1)

```bash
terraform state rm azurerm_key_vault.tf1-key-vault
```

![image](https://github.com/user-attachments/assets/650b9a32-ddba-4dd3-a456-c07d8c8da777)

Ahora, para reflejar los cambios reales, debemos borrar el import que hace referencia al AKV, ya que no está desplegado. Al borrarlo de nuestro state manualmente, no nos dará problemas. Borramos el archivo generated.tf y volvemos a hacer un plan, pero esta vez solo con el import de la cuenta de almacenamiento.

Por otro lado, también debemos eliminarlo del archivo generated.tf, ya que tiene todos los recursos desplegados en la nube de Azure, y, por supuesto, debemos quitar los imports que teníamos antes, ya que el código está en el generated.tf.

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

```
Como vemos, el único cambio que va a realizar el plan es un change, ya que le seteamos valores mayores de cero a las variables del Azure account que estaban seteadas por defecto, pero la estructura es la misma.

![image](https://github.com/user-attachments/assets/6c60d2b4-0dcf-4ee3-a9ca-c5d7d6302f21)


## 1. ¿Qué diferencias observas entre el backup del tfstate de TF2 y el resultado de aplicar las operaciones previas?

El cambio radica en que en el backup se reflejan los dos recursos que había en primera instancia, pero en el actual solo está la cuenta de almacenamiento.

## 2. ¿Qué problemática podrías enfrentar en el tfstate de un Terraform si un recurso de su configuración es eliminado manualmente (sin usar ese Terraform)?

Que el estado que tengo en local no refleja realmente el estado de la infraestructura desplegada en Azure, con lo cual va a haber problemas porque no coinciden las configuraciones.

## 3. ¿Qué maneras se te ocurren para comprobar que el tfstate refleja el estado real de los recursos?

Primero haría un comando plan para ver qué es lo que me falta a mí respecto a lo que hay desplegado en Azure. Después de saber que hay un recurso que no está, procedería a eliminarlo con el comando terraform state rm resource_name. Por último, ahora volvería a hacer un plan para verificar que las configuraciones son las mismas.

## 4. ¿Es necesario mantener los bloques de importación en el archivo main.tf de TF2 después de realizar las operaciones anteriores?

No, lo que hacen los imports realmente es acceder a ese recurso en la nube. Si usamos el comando terraform plan con el uso de la bandera -generate-config-out=generated.tf, lo que hace Terraform es generar esos recursos desplegados en código, es decir, ya los tenemos en local con la misma configuración que está en la nube, con lo cual los imports ya no hacen falta.


