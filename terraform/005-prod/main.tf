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
  
  subscription_id = var.subscription_id
  location        = var.location
  name            = var.network_name
  resource_group  = azurerm_resource_group.network.name
  address_space   = var.address_space
  subnets         = var.subnets
}


resource "azurerm_resource_group" "database" {
  name     = var.database_resource_group
  location = var.location
}

module "database" {
  source      = "../modules/database"

  subscription_id         = var.subscription_id
  network_name            = module.network.name
  network_resource_group  = azurerm_resource_group.network.name
  database_subnet_name    = var.database_subnet_name
  private_dns_zone_name   = var.private_dns_zone_name

  name                    = var.database_server_name
  resource_group          = azurerm_resource_group.database.name
  location                = var.location
  postgresql_version      = var.postgresql_version
  zone                    = var.zone
  storage_mb              = var.storage_mb
  sku_name                = var.sku_name
  create_mode             = var.create_mode
  administrator_login     = var.administrator_login
  administrator_password  = var.administrator_password

  database_config         = var.database_config
}

