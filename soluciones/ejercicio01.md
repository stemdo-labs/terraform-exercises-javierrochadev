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

![image](https://github.com/user-attachments/assets/57c480a9-90d1-41de-810c-1bf4db5f7714)

##### Setear el id de la subscripción

```bash
az account set --subscription "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

![image](https://github.com/user-attachments/assets/fe5281b0-f4bc-441f-a29e-f3add2368950)

##### Setear lñas variables de entorno

```bash
export ARM_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_TENANT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```


![image](https://github.com/user-attachments/assets/3204eb7a-e956-44aa-88e8-a18b35ff0bc3)

##### Aplicación de los cambios

```bash
terraform apply
```

![image](https://github.com/user-attachments/assets/923230ea-17b1-4f7b-8e16-2a1d45d9e7da)

##### Mostrando recurso 

![image](https://github.com/user-attachments/assets/6ba8a2ae-c580-4b73-bc7e-bd29d440c8ec)


![image](https://github.com/user-attachments/assets/57e055a8-dafc-4744-b809-c7bb2ea321bb)




