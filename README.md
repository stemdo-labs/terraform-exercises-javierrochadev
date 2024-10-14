# Ejercicios de _Terraform_ para iniciarse en el Mundo de DevOps

¡Bienvenido/a a los ejercicios básicos de _Terraform_ para iniciarse en el mundo de DevOps!

Este repositorio contiene una serie de ejercicios diseñados para ayudarte a familiarizarte con Terraform y los conceptos básicos de infraestructura como código. Cada ejercicio se centra en un aspecto específico de Terraform y hay que completarlo de acuerdo a la vía de aprendizaje. **¡No rompas el orden!**

## ¡Importante!

Es muy importante que sigas el orden de los ejercicios, ya que cada uno de ellos se basa en los conocimientos adquiridos en los anteriores. Si no sigues el orden, es posible que te encuentres con problemas que no puedas resolver.

Ten mucho cuidado con los valores sensibles que puedas exponer en tus soluciones. Es preferible utilizar variables de entorno para trabajar con este tipo de valores.

Si necesitas introducir valores sensibles en un fichero de configuración terraform.tfvars, asegúrate de que este fichero esté en el .gitignore para evitar subirlo al repositorio.

Actualmente cualquier fichero con el nombre `sensitive.auto.tfvars` está en el .gitignore de este repositorio, por lo que puedes utilizarlo para almacenar valores sensibles.

Si creas un fichero de salida en tus ejecuciones del comando `terraform plan -out=...`, asegúrate de que este fichero tenga de nombre `terraform.tfplan` para que no se suba al repositorio.

## Objetivos

El propósito principal de estos ejercicios es proporcionarte una introducción práctica a los conceptos clave de _Terraform_ que son esenciales para cualquier persona interesada en trabajar en el área de DevOps. Al completar estos ejercicios, esperamos que adquieras experiencia práctica con:

- IaaC (Infraestructura como Código) y su importancia en la gestión de infraestructura.
- Terraform y su sintaxis.
- Creación y uso de módulos Terraform.
- Metodologías de trabajo con Terraform en GitHub Actions.

## Estructura del Repositorio

Este repositorio está organizado de la siguiente manera:

- El directorio `enunciados/` contiene los ejercicios propuestos en este repositorio. Cada archivo proporciona una descripción detallada de los objetivos del ejercicio, así como instrucciones paso a paso sobre lo que se espera que completes.
- El archivo `ASSIGMENT.md` proporciona instrucciones sobre cómo enviar tus soluciones una vez que completes los ejercicios.
- El directorio `soluciones/` será el lugar donde almacenar las soluciones a los ejercicios.
- El directorio `auxiliar/` (opcional) contiene los archivos necesarios para completar los ejercicios. Puedes incluir scripts, archivos de configuración, archivos de texto para edición, etc.
- El directorio `datos/` (opcional) contiene conjuntos de datos u otros archivos de entrada que pueden ser necesarios para los ejercicios.
- El archivo `CONTRIBUTING.md` proporciona instrucciones sobre cómo contribuir al repositorio.

## Contribución

¡Tus contribuciones son bienvenidas! Si tienes ideas para nuevos ejercicios o mejoras para los existentes, no dudes en abrir un issue o abrir un pull request.
