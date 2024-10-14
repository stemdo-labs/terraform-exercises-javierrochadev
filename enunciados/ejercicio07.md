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