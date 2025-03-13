subscription_id = "1aa888f7-e4dd-4ec6-b10e-77d1fa39dc52"
location        = "Poland Central"
resource_tags = {
  "deployment"  = "terraform"
  "environment" = "prod"
}

network_name            = "prod-network"
network_resource_group  = "prod-network-rg"
address_space           = ["10.5.0.0/16"]
subnets = [
  {
    name              ="database-subnet",
    address_prefixes  =["10.5.0.0/24"],
    service_endpoints =["Microsoft.Storage"],
    delegation_name   ="Microsoft.DBforPostgreSQL/flexibleServers",
    delegation_action ="Microsoft.Network/virtualNetworks/subnets/join/action",
  },
  {
    name              ="app-subnet",
    address_prefixes  =["10.5.1.0/24"],
    service_endpoints =[],
    delegation_name   ="",
    delegation_action ="Microsoft.Network/virtualNetworks/subnets/join/action",
  }
]