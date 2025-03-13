provider "azurerm" {
  use_oidc        = true
  subscription_id = var.subscription_id
  features {}
}

resource "azurerm_resource_group" "database" {
  name     = var.resource_group
  location = var.location
}

module "database" {
  source      = "../../modules/database"
  depends_on  = [azurerm_resource_group.database]

  subscription_id         = var.subscription_id
  network_name            = var.network_name
  network_resource_group  = var.network_resource_group
  database_subnet_name    = var.database_subnet_name
  private_dns_zone_name   = var.private_dns_zone_name

  name                    = var.database_server_name
  resource_group          = var.resource_group
  location                = var.location
  postgresql_version      = var.postgresql_version
  administrator_login     = var.administrator_login
  administrator_password  = var.administrator_password
  zone                    = var.zone
  storage_mb              = var.storage_mb
  sku_name                = var.sku_name
  create_mode             = var.create_mode

  database_config         = var.database_config
}

