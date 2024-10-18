terraform {
  required_version = ">= 0.12"
  required_providers{
   azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
  
    # backend "azurerm"{
    #   storage_account_name = "stajrochadvfinlab"
    #   container_name       = "terraform-state"
    #   key                  = "terraform.tfstate"
    #   resource_group_name  = "rg-jrocha-dvfinlab"
    # }

}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}


# Llamada a modulo para la creación de una red virutal

module "vnet"{
    source              = "./modules/vnet"
    name                = "main-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = var.resource_group_name

}

# Llamada a modulo de creación de las subredes
module "subnet" {
  source               = "./modules/subnet"
  depends_on           = [module.vnet]
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.vnet.vnet_name
  subnets              = var.subnets
}

# Llamada a modulo para la creación de un grupo de seguridad en la red

module "nsg"{
  source                      = "./modules/nsg"
  depends_on                  = [module.vnet, module.subnet]
  network_security_group_name = var.network_security_group_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
}

# Llamada a modulo para la creacion de asociaciaciones entre subnets

module "snsga" {
  source                    = "./modules/snsga"
  depends_on                = [module.nsg, module.subnet]
  subnet_ids                = module.subnet.subnet_ids
  network_security_group_id = module.nsg.id
}

# Llamada a modulo para la creación de un IP pública.

module "public-ip" {
  source              = "./modules/ip"
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Llamda a modulo para crear interfaces de red

module "interface" {
  source                  = "./modules/interface"
  network_interface_name  = var.network_interface_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  subnet_ids              = module.subnet.subnet_ids
}

# Llamada a modulo para crear interfaces para el balanceador de cargas para cada subnet

# module "lb-pool" {
#   source                  = "./modules/poolassoc"
#   network_interface_ids   = module.interface.network_interface_ids
#   public_ip_name          = var.public_ip_name
# }

# Llamada a modulo para la creación de maquinas virtuales

module "my_vm" {
  source                = "./modules/vm"
  virtual_machines      = var.virtual_machines
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = module.interface.network_interface_ids
}