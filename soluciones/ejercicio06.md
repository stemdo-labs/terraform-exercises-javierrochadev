# Ejercicio 06

## Objetivos

- Introducción a la utilización de módulos remotos.

## Pre-requisitos

- Haber completado el ejercicio05.

## Enlaces de Interés

- [Uso de source en bloques de tipo Module](https://developer.hashicorp.com/terraform/language/modules/sources).

## Enunciado

Sube el módulo creado en el ejercicio anterior a un repositorio de GitHub (si se han seguido las instrucciones, ya debería estar localizado en la entrega del ejercicio previo).

Crea un nuevo fichero `main.tf` que haga uso del módulo localizado en el repositorio remoto.

Añade también un fichero `variables.tf` para definir las variables de entrada del módulo, un fichero `outputs.tf` para definir las salidas del módulo y un fichero `terraform.tfvars` para definir los valores de las variables de entrada (reutiliza todo lo que sea posible del ejercicio anterior).

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).

Para usar un modulo remoto primero debemos de conocer en que plataforma esta este archivo alojado, y esque terraform es capaz de distinguir la plataforma de alojamiento del modulo para realizar la descarga de este de manera mas accesible para el usuario, por ejemplo es capaz de abrir el navegador para pedirnos a modo de click la autenticación para poder usar ese modulo, tambien podemos almacenarlo en un repo público para poder usarlo sin problemas de autenticación.
