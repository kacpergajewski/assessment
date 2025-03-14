terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.22.0"
    }
  }
}

data "azurerm_subscription" "default" {
  subscription_id = var.subscription_id
}

resource "azurerm_private_dns_zone" "database" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group
}

resource "azurerm_private_dns_zone_virtual_network_link" "database" {
  depends_on = [azurerm_private_dns_zone.database]

  name                  = "${var.private_dns_zone_name}-link"
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.network_id
  resource_group_name   = var.resource_group
}

resource "azurerm_postgresql_flexible_server" "default" {
  depends_on = [azurerm_private_dns_zone_virtual_network_link.database]

  name                          = var.name
  resource_group_name           = var.resource_group
  location                      = var.location
  delegated_subnet_id           = var.database_subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.database.id
  public_network_access_enabled = false
  sku_name                      = var.sku_name
  storage_mb                    = var.storage_mb
  version                       = var.postgresql_version
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

  # lifecycle {
  #   prevent_destroy = true
  # }
}