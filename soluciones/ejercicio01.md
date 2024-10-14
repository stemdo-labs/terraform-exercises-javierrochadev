# Ejercicio 01

## Objetivos

- Tener un primer contacto con Terraform.
- Configurar proveedor de azure para utilizar un Service Principal.

## Pre-requisitos

- Disponer de los siguientes recursos:
  - Subscripción de Azure.
  - Azure KeyVault.
  - Service Principal en Azure.

## Enunciado

Documenta este ejercicio dando una breve explicación (una línea) de cada uno de los pasos del proceso.

Sigue los puntos del siguiente [Tutorial Guiado][GuidedDoc], intercambiando la creación del service principal por cómo rescatar sus valores usando azure cli. (Recuerda ocultar los valores sensibles en las capturas de pantalla).

[GuidedDoc]: https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build

## Entregables

**IMPORTANTE:** ¡Cuidado con exponer los valores sensibles!

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).


##### Comprobación de la intalación de azure CLI

![image](https://github.com/user-attachments/assets/58459fcd-afee-4737-84c5-3895b8df8ffa)

##### Login de azure en la terinal

```bash
az login
```
![image](https://github.com/user-attachments/assets/880caa5f-01dd-4e4d-8edf-7b0331cc32ca)


##### Setear el id de la subscripción

```bash
az account set --subscription "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

![image](https://github.com/user-attachments/assets/6d3c7297-4d71-4ef8-8f52-245b1d2ed547)


##### Setear las variables de entorno

```bash
export ARM_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_TENANT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

![image](https://github.com/user-attachments/assets/90a67cf9-9432-4cf7-ad15-97703643c3d4)

![Uploading image.png…]()


##### Aplicación de los cambios

```bash
terraform apply
```

![image](https://github.com/user-attachments/assets/6b659d31-6fdb-4ca9-8c75-52176f740d10)


##### Mostrando recurso 

![image](https://github.com/user-attachments/assets/0cdbf8d9-1911-481d-83d7-ba93d7b84f3c)

![image](https://github.com/user-attachments/assets/57e055a8-dafc-4744-b809-c7bb2ea321bb)




