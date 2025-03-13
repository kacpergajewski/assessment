subscription_id = "1aa888f7-e4dd-4ec6-b10e-77d1fa39dc52"
location        = "Poland Central"
resource_tags = {
  "deployment"  = "terraform"
  "environment" = "prod"
}

network_name            = "prod-network"
network_resource_group  = "network-rg"
database_subnet_name    = "database-subnet"
private_dns_zone_name   = "prod.kacpergajewski.postgres.database.azure.com"

database_server_name    = "prod"
sku_name                = "B_Standard_B1ms"
storage_mb              = 32768
version                 = "12"
zone                    = "2"
create_mode             = "Default"

database_config = [
  {
    name = "prod"
    charset = "UTF8"
    collation = "en_US.utf8"
  }
]