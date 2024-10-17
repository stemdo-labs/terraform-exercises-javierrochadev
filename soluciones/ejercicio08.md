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


##### Creación de contendoor

Primero debemos de crear mediante código un container para poder almacenar datos, lo haremos mediante terraform porque en la insterfaz de Azure no se tienen permisos para ello.

```hcl
resource "azurerm_storage_container" "my_container"{
  name                  = "terraform-state"
  storage_account_name  = var.account_name
  container_access_type = "private"
}
```

Aquí podemos ver en la cuenta de Azure como se ha creado nuestro contenedor para poder subir datos y dejarlos alli de manera permanente.

![image](https://github.com/user-attachments/assets/0df61e42-00cf-4052-a613-2d541f52d5ec)

##### Configuración de backend

Con la directiva Backend podemos definir cómo se va a comportar nuestro código, es decir, vamos a poder decirle dónde tiene que ir a buscar el tfstate de manera remota. La primera vez que hacemos el init nos pregunta si queremos compartir el estado en la red de Azure, y las siguientes veces, cada vez que hagamos un apply, irá a buscar el estado remoto para iniciar las comparaciones.

Podemos incluirlo en la directiva terraform o bien hacerlo en un backend.tf de manera solitaria. Le indicamos sobre qué cuenta de almacenamiento va a actuar, así como el nombre del container que creamos anteriormente, verificando su existencia. El archivo que vamos a usar para refrescar el estado o subirlo por primera vez, como es este caso, y por último, indicarle el grupo de recursos.

```hcl
 backend "azurerm"{
      storage_account_name = "stajrochadvfinlab"
      container_name       = "terraform-state"
      key                  = "terraform.tfstate"
      resource_group_name  = "rg-jrocha-dvfinlab"
    }
```

Aquí podemos ver como al ejecutar el init nos pregunta si queremos compartir el estado de manera remota, le proporcinamos la respuesta positiva y todo marcha bien.

```bash
terraform init
```
![image](https://github.com/user-attachments/assets/66b81112-7f66-45e8-bf5e-e37216f133c9)






