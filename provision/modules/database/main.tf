terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.21.1"
    }
  }
}

data "azurerm_subscription" "current" {
  subscription_id = var.subscription_id
}

data "azurerm_virtual_network" "default" {
  name                = var.network_name
  resource_group_name = var.network_resource_group
}

data "azurerm_subnet" "name" {
  name                  = var.database_subnet_name
  resource_group_name   = var.network_resource_group
  virtual_network_name  = var.network_name
}

resource "azurerm_private_dns_zone" "database" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group
}

resource "azurerm_private_dns_zone_virtual_network_link" "database" {
  name                  = "${var.private_dns_zone_name}-link"
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = data.azurerm_virtual_network.default.id
  resource_group_name   = var.resource_group
}

resource "azurerm_postgresql_flexible_server" "default" {
  depends_on = [azurerm_private_dns_zone_virtual_network_link.database]

  name                          = var.name
  resource_group_name           = var.resource_group
  location                      = var.location
  delegated_subnet_id           = data.azurerm_subnet.database.id
  private_dns_zone_id           = azurerm_private_dns_zone.database.id
  public_network_access_enabled = false
  sku_name                      = var.sku_name
  storage_mb                    = var.storage_mb
  version                       = var.version
  zone                          = var.zone
  create_mode                   = var.create_mode
  administrator_login           = var.administrator_login
  administrator_password        = var.administrator_password
}

resource "azurerm_postgresql_flexible_server_database" "default" {
  depends_on = [azurerm_postgresql_flexible_server.default]
  for_each = {
    for database in var.database_config : database.name => database
  }

  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.default.id
  charset   = each.value.charset
  collation = each.value.collation
}