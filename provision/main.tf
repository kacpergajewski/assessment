terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-rg"
    storage_account_name  = "kacpergajewskiterraform"
    container_name        = "prod"
    key                   = "prod.main.tfstate"
  }
}

provider "azurerm" {
  use_oidc        = true
  subscription_id = var.subscription_id
  features {}
}

resource "azurerm_resource_group" "network" {
  name     = var.network_resource_group
  location = var.location
}

module "network" {
  source      = "./modules/virtual-network"
  depends_on  = [azurerm_resource_group.network]
  
  subscription_id = var.subscription_id
  location        = var.location
  name            = var.network_name
  resource_group  = azurerm_resource_group.network.name
  address_space   = var.address_space
  subnets         = var.subnets
}

