terraform {
  required_version = ">= 0.12"
  required_providers{
   azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
  # backend "azurerm"{
  #     storage_account_name = "stajrochadvfinlab"
  #     container_name       = "terraform-state"
  #     key                  = "terraform.tfstate"
  #     resource_group_name  = "rg-jrocha-dvfinlab"
  #   }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}

module "vnet" {
  # source                        = "git::github.com/javierrochadev/remote_modules/modules/vnet"
  source                        = "./modules/vnet"
  vnet_name                     = var.vnet_name
  existent_resource_group_name  = var.existent_resource_group_name
  location                      = var.location
  vnet_address_space            = var.vnet_address_space
  owner_tag                     = var.owner_tag
  environment_tag               = var.environment_tag
  vnet_tags                     = var.vnet_tags
  subnets                       = var.subnets

}

# Llamada al module para crear el grupo de seguridad

module "gs"{
  source                       = "./modules/gs"
  location                     = var.location
  existent_resource_group_name = var.existent_resource_group_name
}

# Llamada al modulo subnets para crear las subredes

module "subnet" {
  source                        = "./modules/subnet"
  resource_group_name           = var.existent_resource_group_name
  virtual_network_name          = var.vnet_name
  subnets                       = var.subnets
  network_security_group_id     = module.gs.network_security_group_id
  depends_on                    = [module.vnet]
  
}

# TENEMOS QUE MIRAR BIEN EL NOMBRE DE LAS VARIABLES PARA REFERENCIARLAS COMO ES DEBIDO

module "snsg"{
  source                     = "./modules/ngs"
  subnet_ids                 = module.subnet.subnet_ids
  network_security_group_id  = module.gs.network_security_group_id
}


resource "azurerm_storage_container" "my_container"{
  name                  = "terraform-state"
  storage_account_name  = var.account_name
  container_access_type = "private"
}

