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
az account set --subscription "86f76907-b9d5-46fa-a39d-aff8432a1868"
```

![image](https://github.com/user-attachments/assets/fe5281b0-f4bc-441f-a29e-f3add2368950)

##### Crear una nueva entidad de servicio en Azure

´´´bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/86f76907-b9d5-46fa-a39d-aff8432a1868"
```


