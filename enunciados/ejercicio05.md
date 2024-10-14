# Ejercicio 05

## Objetivos

- Introducción a la utilización de módulos.
- Importación de módulos locales.

## Pre-requisitos

- Haber completado el ejercicio 04.

## Enlaces de Interés

- [Uso de source en bloques de tipo Module](https://developer.hashicorp.com/terraform/language/modules/sources).

## Enunciado

Utilizando el contenido desarrollado durante los ejercicios anteriores, crea un módulo de terraform siguiendo la estructura recomendada por HashiCorp.

Una vez hecho esto, procede con los siguientes pasos:

Crea un nuevo módulo que disponga de un fichero `main.tf`. Añade también un fichero `variables.tf` para definir las variables de entrada, un fichero `outputs.tf` para definir las salidas y un fichero `terraform.tfvars` para definir los valores de las variables de entrada (reutiliza los valores del `ejercicio04`). Este módulo debe utilizar el módulo creado en el proceso anterior, que aún debe estar en local.

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).