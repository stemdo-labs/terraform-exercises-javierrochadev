# Ejercicio 03

## Objetivos

- Introducción al uso de funciones de terraform.
- Avanzar en la parametrización de módulos, profundizando en los tipos de variables y su uso para estandarizar requisitos en la configuración de infraestructura (a través de la inclusión de tags obligatorias y adicionales).

## Enlaces de Interés

- [Funciones de Terraform](https://developer.hashicorp.com/terraform/language/functions)
- Se puede hacer uso del comando [terraform console](https://developer.hashicorp.com/terraform/cli/commands/console) para probar funciones y expresiones.

## Enunciado

Modifica el ejercicio anterior e incluye tres nuevas variables:

- `owner_tag`:
  - Tipo: `string`
  - Obligatoria.
  - Describe el propietario de la VNet.
- `environment_tag`:
  - Tipo: `string`
  - Obligatoria.
  - Describe el entorno de la VNet (`dev`, `test`, `prod`, etc).
- `vnet_tags`:
  - Tipo: `mapa de strings`
  - Opcional, siendo su valor por defecto un mapa vacío.
  - Describe los tags adicionales que se aplicarán a la VNet.

El módulo debe utilizar estas variables para formar los tags de la VNet, incluyendo los tags obligatorios `owner` y `environment` y los tags adicionales que se especifiquen en `vnet_tags`. Si en `vnet_tags` se especifica un tag con el mismo nombre que `owner` o `environment`, se debe sobreescribir el valor de estos últimos por el valor de `vnet_tags`.

Despliega el recurso en Azure utilizando el módulo desarrollado, documentando el proceso en el entregable.

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).