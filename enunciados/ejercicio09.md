# Ejercicio 09

## Objetivos
El objetivo de este ejercicio es comprender el uso de terraform import y cómo afecta al tfstate en situaciones concretas. Se presentarán dos escenarios para explorar estos conceptos.

# Entregables

**IMPORTANTE:**
- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).
- Se adjuntará, un archivo respuestas.md, donde se escribirán las respuestas a las preguntas 

# Primera Parte: Importar Recursos Existentes en Azure.
En esta parte, trabajarás con recursos que ya existen en Azure pero que no están reflejados en el archivo de configuración de Terraform.

1. Añadir los bloques de terraform import en el archivo main.tf para los siguientes recursos:
        Azure Resource Group
        Azure Key Vault
        Azure Storage Account
    Nota: No definas los recursos explícitamente en Terraform, solo añade los bloques de importación necesarios.

2. Ejecutar terraform plan -generate-config-out="generated.tf"  (es posible que debas ajustar este comando) para generar el código de los  
   recursos.

3. Revisar el código generado en el archivo generated.tf. ¿Qué observas? ¿Es el código generado exactamente lo que esperabas?

4. Ejecutar los comandos terraform init, terraform plan y terraform apply

5. ¿Qué sucede cuando importas un recurso que ya existe en Azure pero no en el archivo de configuración de Terraform?

6. ¿Cómo afecta la importación al tfstate? ¿Qué diferencias observas en el estado después de aplicar los cambios?


# Segunda Parte: Manejar la Eliminación de un Recurso Externo
En esta parte, investigarás qué sucede con el tfstate si se elimina un recurso en Azure sin utilizar Terraform.

1. Crear manualmente un Network Security Group (NSG) en Azure a través del portal.

2. Añadir un bloque de terraform import en main.tf para importar el NSG al tfstate.

3. Ejecutar terraform show para verificar que el estado refleja correctamente el NSG y otros recursos.

4. Eliminar el NSG desde el portal de Azure.

5. Actualizar el tfstate para reflejar la eliminación del NSG. ¿Cómo podrías eliminar el recurso del tfstate?

6. Reflexiona sobre los bloques de importación en main.tf. ¿Es necesario mantenerlos una vez que el recurso ha sido eliminado?

7. ¿Qué sucede en el tfstate cuando eliminas un recurso en Azure sin utilizar Terraform?

8. ¿Cómo puedes asegurarte de que el tfstate refleja el estado real de tus recursos?

9. ¿Qué pasos adicionales son necesarios después de importar y  después de eliminar recursos?


## Enlaces de interés

- Documentación oficial: https://registry.terraform.io/

- Terraform import: https://developer.hashicorp.com/terraform/language/import/generating-configuration

- Terraform state rm: https://developer.hashicorp.com/terraform/cli/commands/state/rm
