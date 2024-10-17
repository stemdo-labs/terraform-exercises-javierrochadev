# Ejercicio 07

## Objetivos

- Crear un módulo completo de terraform.

## Pre-requisitos

- Haber completado todos los ejercicios anteriores y la guía de aprendizaje hasta el bloque *"Expresiones, Iteraciones y Módulos"* (inclusive).

## Enlaces de Interés

- [Recurso para asociar Network Security Groups a Subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association)

## Enunciado

Haciendo uso de las recomendaciones para la estructuración de módulos de Terraform definidas por HashiCorp, modifica el módulo creado a lo largo de los ejercicios anteriores para cumplir con los siguientes requisitos:

- El módulo debe ser capaz de crear:
  - Una VNet sobre un grupo de recursos existente o crear dicho grupo si no existe.
  - Cero o varias subnets dentro de la VNet. _(Utiliza módulos anidados para esto)_
  - **[¡¡OPCIONAL!!]** Cero o varios network security groups asociados a una o varias subnets. _(Utiliza módulos anidados para esto)_
- El módulo debe contener las validaciones que consideres necesarias para asegurar su correcto funcionamiento. <br/>**Nota:** Recuerda que los recursos de azurerm ya contienen validaciones por defecto que no son necesarias repetir, solo utiliza las validaciones que aporten valor para tu caso de uso.
- No es necesario definir todos los argumentos de los recursos proporcionados por azurerm, solo los **obligatorios** (es decir, en la documentación de azurerm, solo deben usarse los argumentos especificados como obligatorios bajo la sección *Argument Reference*).

Una vez completado el módulo, crea un ejemplo de uso que contenga la creación de una VNet con dos subnets.

Si se ha decidido desarrollar el apartado opcional, crea también un network security group asociado a una de las subnets anteriores. No es necesario que las reglas del network security group tenga sentido, simplemente añade reglas de ejemplo.

El ejemplo de uso puede constar de un solo fichero `main.tf` si se desea.

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).

##### Contenido de main.tf

En este arhcivo principal llamamaos a todos los modulos anidados que vaoms a usar, todos ellos estan alojados en el directorio modules/module_name correspondiente.

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
  # source                        = "git::github.com/javierrochadev/remote_modules/modules/vnet"
  source                        = "./modules/vnet"
  vnet_name                     = var.vnet_name
  existent_resource_group_name  = var.existent_resource_group_name
  location                      = var.location
  vnet_address_space            = var.vnet_address_space
  owner_tag                     = var.owner_tag
  environment_tag               = var.environment_tag
  vnet_tags                     = var.vnet_tags
  subnets                       = var.subnets

}

# Llamada al module para crear el grupo de seguridad

module "gs"{
  source                       = "./modules/gs"
  location                     = var.location
  existent_resource_group_name = var.existent_resource_group_name
}

# Llamada al modulo subnets para crear las subredes

module "subnet" {
  source                        = "./modules/subnet"
  resource_group_name           = var.existent_resource_group_name
  virtual_network_name          = var.vnet_name
  subnets                       = var.subnets
  network_security_group_id     = module.gs.network_security_group_id
  depends_on                    = [module.vnet]
  
}

# TENEMOS QUE MIRAR BIEN EL NOMBRE DE LAS VARIABLES PARA REFERENCIARLAS COMO ES DEBIDO

module "snsg"{
  source                     = "./modules/ngs"
  subnet_ids                 = module.subnet.subnet_ids
  network_security_group_id  = module.gs.network_security_group_id
}

```

##### Contenido main del modulo vnet

En este módulo definimos la creación del recurso para crear la red virtual, haciendo uso de las variables que le pasamos como parámetro. 


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

##### Contenido de main.tf del modulo gs

En este modulo creamos un recurso para la creación de un grupo de seguridad para la red que hemos creado, haciendo referencia al nombre del grupo que está en Azure ya creado. Por último, llamamos al módulo subnet para crear subredes a partir de la red principal que hemos creado, pasando como parámetro las variables que le hacen falta. Cabe destacar que le pasamos como parámetro una lista de objetos con los valores de las subredes que vamos a crear, con el nombre y la IP de cada una de ellas. En este caso, hemos usado dos subredes con una máscara de subred /17, ya que la red principal es /16. En este caso, solo hemos considerado hacer dos redes sin posibilidad de escalabilidad, pero solo es una prueba.

```hcl
resource "azurerm_network_security_group" "nsg" {
  name                = "example-nsg"
  location            = var.location
  resource_group_name = var.existent_resource_group_name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
```

##### Contenido de main.tf del modulo subnet

En este archivo podemos ver cómo hacemos una iteración para crear las distintas redes. En este caso, solo creamos dos, haciendo uso de la variable count para realizar la creación de tantos recursos como esta variable tenga valor. Para el nombre de la subred, hacemos uso de la variable name de cada uno de los objetos almacenados en var.subnets, previamente especificados, y como valor de address_prefixes, le seteamos el valor de la variable address_prefixes que está dentro del objeto que se está recogiendo.

Para acceder a una posición específica, usamos la variable index dentro del objeto count.


```yaml
resource "azurerm_subnet" "v_net_subnet" {
  count                         = length(var.subnets)
  name                          = var.subnets[count.index].name
  resource_group_name           = var.resource_group_name
  virtual_network_name          = var.virtual_network_name
  address_prefixes              = var.subnets[count.index].address_prefixes
}


```
##### Contendio de main de modulo ngs

Volvemos a usar el count para poder crear dinámicamente, en función de los IDs recogidos del módulo anterior, todos los grupos de asociación de seguridad para cada subred creada, usando el ID de cada una de ellas y el ID del grupo principal de seguridad. Y así estaría toda la infraestructura de red creada con los requisitos que se piden.


´´`yaml
resource "azurerm_subnet_network_security_group_association" "snsg" {
  count                     = length(var.subnet_ids)
  subnet_id                 = var.subnet_ids[count.index]
  network_security_group_id = var.network_security_group_id
}
´´´

## Nota

Hay que definir los outputs como variables para que puedan ser usadas en el módulo principal de cada uno de ellos, como es el caso de los IDs, ya que son valores que se han creado dinámicamente.

##### Capturas de ejemplo dobre el funcionamiento

```bash
terraform apply
```
![image](https://github.com/user-attachments/assets/397ac288-395a-4385-81e7-d2456a68a26a)

##### Creación del grupo de seguridad en Azure

![image](https://github.com/user-attachments/assets/8d4edbf6-47b6-4235-9a68-39622afb79e8)

## Se adnjunta la confiruación de la red en formato json en la carpeta auxiliares





