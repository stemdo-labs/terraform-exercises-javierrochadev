# Ejercicio 04

## Objetivos

- Practicar la validación de variables en módulos de Terraform.
- Combinar el uso de funciones de terraform.
- Introducción opcional al uso de expresiones regulares como herramienta para validación.

## Enlaces de Interés

- [Funciones de Terraform](https://developer.hashicorp.com/terraform/language/functions)
- [terraform console](https://developer.hashicorp.com/terraform/cli/commands/console)
- [Expresiones en Terraform](https://developer.hashicorp.com/terraform/language/expressions)

## Enunciado

Modifica el ejercicio anterior para que se cumplan las siguientes condiciones:

- `owner_tag`,`environment_tag` y `vnet_name` no pueden ser cadenas vacías ni ***nullable***.
- En `environment_tags`, los valores de los tags solo pueden contener uno de los siguientes valores, sin tener en cuenta mayúsculas o minúsculas (es decir, tanto 'dev', como 'DEv', como 'DEV' son valores aceptados): 'DEV', 'PRO', 'TES', 'PRE'.<br/>**Consejo:** Utiliza la función `contains` de Terraform en combinación con otras.
- `vnet_tags` no pueder null y además ninguno de los valores del mapa puede ser null o cadena vacía. 

Se debe elegir una de las siguientes opciones para validar la variable `vnet_name`:

### Opción 1 (Menor dificultad)

Debe cumplirse que comience siempre por `vnet`.

### Opción 2 (Mayor dificultad)

**Nota**: Esta opción está ideada para el uso de expresiones regulares.

Debe cumplirse que comience por `vnet` seguido de más de dos caracteres contenidos en el rango `[a-z]` y que termine por `tfexercise` seguido de al menos dos dígitos numéricos. Algunos ejemplos de valores aceptados y no aceptados serían:
  - `vnetprodrigueztfexercise01` -> Aceptado.
  - `vnetprodrigueztfexercise` -> No aceptado.
  - `vnetprodrigueztfexercise1` -> No aceptado.
  - `vnetpr0drigu3ztfexercise01` -> No aceptado.
  - `vnetprodrigueztfexercises01` -> No aceptado.
  - `vetprodrigueztfexercise01` -> No aceptado.
  - `vnetProdrigueztfexercise01` -> No aceptado.

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).