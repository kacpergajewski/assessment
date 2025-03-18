subscription_id = "1aa888f7-e4dd-4ec6-b10e-77d1fa39dc52"
location        = "Poland Central"
resource_tags = {
  "deployment"  = "terraform"
  "environment" = "prod"
}

network_name           = "prod-network"
network_resource_group = "prod-network-rg"
address_space          = ["10.5.0.0/16"]
subnets = [
  {
    name              = "database-subnet",
    address_prefixes  = ["10.5.0.0/24"],
    service_endpoints = ["Microsoft.Storage"],
    delegation_name   = "Microsoft.DBforPostgreSQL/flexibleServers",
    delegation_action = "Microsoft.Network/virtualNetworks/subnets/join/action",
  },
  {
    name              = "app-subnet",
    address_prefixes  = ["10.5.1.0/24"],
    service_endpoints = [],
    delegation_name   = "",
    delegation_action = "Microsoft.Network/virtualNetworks/subnets/join/action",
  }
]

database_subnet_name    = "database-subnet"
private_dns_zone_name   = "prod.postgres.database.azure.com"
database_server_name    = "prod-kacpergajewski"
database_resource_group = "prod-database-rg"
sku_name                = "B_Standard_B1ms"
storage_mb              = 32768
postgresql_version      = "12"
zone                    = "2"
create_mode             = "Default"

database_config = [
  {
    name      = "app"
    charset   = "UTF8"
    collation = "en_US.utf8"
  }
]