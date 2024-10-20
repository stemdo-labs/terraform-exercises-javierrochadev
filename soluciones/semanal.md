# Explicación 

Este modulo es un modulo de terrafrom el cual va a crear un número determinado de subredes dentro de una red con un mismo grupo de seguridad asociadas entres si,
va a disponer de un abalanceador de cargas con unas politicas de transito de la información tanto de entrada a los servidores como de salida de estos hacia la red,
dispondra de una ip pública para el acceso a estos.

Todo esto depende del número de máquinas cirtuales que se faciliten para cada una de ellas se generar una subred y una interfaz de red.

## 1. Creación de una red virtual

```hcl
module "vnet" {
    source              = "./modules/vnet"
    name                = "main-vnet-test"
    address_space       = var.vnet_address_space
    location            = var.location
    resource_group_name = var.resource_group_name
}
```

### Descripción

Este módulo crea una red virtual (**vnet**) en **Azure**. Se le proporciona un nombre, un espacio de direcciones (definido en una variable), la ubicación geográfica y el nombre del grupo de recursos donde se creará la red.

## 2. Creación de subredes

```hcl
module "subnet" {
    source               = "./modules/subnet"
    depends_on           = [module.vnet]
    resource_group_name  = var.resource_group_name
    virtual_network_name = module.vnet.vnet_name
    subnets              = local.subnets
}
```

### Descripción

Este módulo crea subredes dentro de la red virtual creada en el módulo anterior. Utiliza la variable de grupo de recursos y el nombre de la red virtual. La creación de subredes depende de que la red virtual esté configurada.

## 3. Creación de un grupo de seguridad de red (NSG)

```hcl
module "nsg" {
    source                      = "./modules/nsg"
    depends_on                  = [module.vnet, module.subnet]
    network_security_group_name = var.network_security_group_name
    location                    = var.location
    resource_group_name         = var.resource_group_name
}
```

### Descripción

Este módulo configura un grupo de seguridad de red (**NSG**) para controlar el tráfico de red hacia y desde los recursos dentro de la red virtual. Se especifica el nombre del **NSG**, la ubicación y el grupo de recursos, y depende de que la red virtual y las subredes se hayan creado primero.

## 4. Asociación de subredes y NSG

```hcl
module "snsga" {
    source                    = "./modules/snsga"
    depends_on                = [module.nsg, module.subnet]
    subnet_ids                = module.subnet.subnet_ids
    network_security_group_id = module.nsg.id
}
```

### Descripción

Este módulo asocia las subredes creadas con el grupo de seguridad de red (**NSG**). La creación de esta asociación depende de que tanto el **NSG** como las subredes estén configurados.

## 5. Creación de una dirección IP pública

```hcl
module "public-ip" {
    source              = "./modules/ip"
    name                = var.public_ip_name
    location            = var.location
    resource_group_name = var.resource_group_name
    sku                 = var.sku
}
```

### Descripción

Este módulo crea una dirección IP pública que puede ser utilizada por otros recursos (como máquinas virtuales o balanceadores de carga). Se configura con un nombre, ubicación, grupo de recursos y **SKU**.

## 6. Creación de Interfaces de Red

```hcl
module "interface" {
    source                  = "./modules/interface"
    network_interface_name  = var.network_interface_name
    location                = var.location
    resource_group_name     = var.resource_group_name
    subnet_ids              = module.subnet.subnet_ids
}
```

### Descripción
Este módulo crea interfaces de red que permiten a las máquinas virtuales conectarse a la red virtual y a las subredes. Se asocia con las subredes creadas previamente.

## 7. Asociación de Interfaces con el Balanceador de Carga

```hcl
module "lb-pool-assoc" {
    source                  = "./modules/poolassoc"
    depends_on              = [module.public-ip, module.interface, module.lb_pool]
    network_interface_ids   = module.interface.network_interface_ids
    public_ip_name          = var.public_ip_name
    backend_address_pool_id = module.lb_pool.backend_address_pool_id
}
```

### Descripción
Este módulo asocia las interfaces de red creadas con el balanceador de carga. Esto permite que las interfaces se integren en el backend del balanceador de carga.

## 8. Creación de Máquinas Virtuales

```hcl
module "my_vm" {
    source                = "./modules/vm"
    virtual_machines      = local.virtual_machines
    location              = var.location
    resource_group_name   = var.resource_group_name
    network_interface_ids = module.interface.network_interface_ids
}
´´´
### Descripción
Este módulo crea las máquinas virtuales en Azure. Se configura con una lista de máquinas virtuales (definida en un archivo local), ubicación, grupo de recursos y las interfaces de red asociadas.

## 9. Creación de un Balanceador de Carga

```hcl
module "lb" {
    source               = "./modules/lb"
    load_balancer_name   = var.load_balancer_name
    location             = var.location
    resource_group_name  = var.resource_group_name
    sku                  = var.sku
    public_ip_name       = var.public_ip_name
    public_ip_address_id = module.public-ip.public_ip_id
}
```

### Descripción
Este módulo configura un balanceador de carga en Azure, que distribuirá el tráfico entre las máquinas virtuales. Se proporciona un nombre, ubicación, grupo de recursos, SKU y la dirección IP pública asociada.

## 10. Creación de un Grupo de Direcciones IP para el Balanceador de Carga

```hcl
module "lb_pool" {
    source                       = "./modules/lbpool"
    loadbalancer_id              = module.lb.load_balancer_id
    lb_pool_name                 = var.lb_pool_name
}
```
### Descripción
Este módulo crea un grupo de direcciones IP que el balanceador de carga utilizará para dirigir el tráfico. Se vincula al balanceador de carga creado anteriormente.

## 11. Manejo del Sondeo de Instancias

```hcl
module "lb_probe" {
    source              = "./modules/lbprobe"
    loadbalancer_id     = module.lb.load_balancer_id
    lb_probe_name       = var.lb_probe_name
    port                = var.port
}
´´´
### Descripción
Este módulo configura un sondeo (health probe) para verificar la disponibilidad de las instancias de las máquinas virtuales detrás del balanceador de carga. Se especifica el nombre del sondeo y el puerto a utilizar.

## 12. Definición de Reglas de Balanceo

```hcl
module "lb_rule" {
    source                         = "./modules/lbrule"
    loadbalancer_id                = module.lb.load_balancer_id
    rule_name                      = var.rule_name
    rule_protocol                  = var.rule_protocol
    frontend_port                  = var.port
    backend_port                   = var.port
    public_ip_name                 = var.public_ip_name
    probe_id                       = module.lb_probe.lb_probe_id
    backend_address_pool_ids       = [module.lb_pool.backend_address_pool_id]
}
```

### Descripción
Este módulo define las reglas de balanceo de carga que determinan cómo se dirige el tráfico entre el frontend y el backend. Incluye información sobre los puertos, el protocolo y se vincula al sondeo de salud.

## 13. Definición de Reglas de Tráfico Saliente

```hcl
module "lboutbound_rule" {
    source                  = "./modules/lboutrule"
    lb_out_rule_name        = var.lb_out_rule_name
    loadbalancer_id         = module.lb.load_balancer_id
    rule_protocol           = var.rule_protocol
    backend_address_pool_id = module.lb_pool.backend_address_pool_id
    public_ip_name          = var.public_ip_name
}
```

### Descripción
Este módulo define las reglas para el tráfico saliente del balanceador de carga. Permite especificar el comportamiento del tráfico que sale de las instancias detrás del balanceador.

