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
  source      = "../modules/network"
  depends_on  = [azurerm_resource_group.network]
  
  subscription_id = var.subscription_id
  location        = var.location
  name            = var.network_name
  resource_group  = azurerm_resource_group.network.name
  address_space   = var.address_space
  subnets         = var.subnets
}