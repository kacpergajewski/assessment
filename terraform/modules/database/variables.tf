variable "subscription_id" {
  type        = string
  description = "ID of the subscription where the resource will be deployed."
}

variable "location" {
  type        = string
  default     = "Poland Central"
  description = "Location for the resources. Changing this forces a new resource to be created."
}

variable "resource_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the resource."
}


variable "network_id" {
  type        = string
  description = "ID of network to give access to private DNS zone to."
}

variable "database_subnet_id" {
  type        = string
  description = "ID of the virtual network subnet to create the PostgreSQL Flexible Server."
}

variable "private_dns_zone_name" {
  type        = string
  description = "(Required) The name of the Private DNS Zone. Must be a valid domain name. Changing this forces a new resource to be created."
}



variable "name" {
  type        = string
  description = "(Required) The name which should be used for this PostgreSQL Flexible Server. Changing this forces a new PostgreSQL Flexible Server to be created."
}

variable "resource_group" {
  type        = string
  description = "(Required) The name of the Resource Group where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created."
}

variable "sku_name" {
  type        = string
  description = "(Optional) The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3)."
}

variable "storage_mb" {
  type        = string
  description = "(Optional) The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4193280, 4194304, 8388608, 16777216 and 33553408."
}

variable "postgresql_version" {
  type        = string
  description = "(Optional) The version of PostgreSQL Flexible Server to use. Possible values are 11, 12, 13, 14, 15 and 16. Required when create_mode is Default."
}

variable "zone" {
  type        = string
  description = "(Optional) Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located."
}

variable "create_mode" {
  type        = string
  description = "(Optional) The creation mode which can be used to restore or replicate existing servers. Possible values are Default, GeoRestore, PointInTimeRestore, Replica and Update. Changing this forces a new PostgreSQL Flexible Server to be created."
}

variable "administrator_login" {
  type        = string
  description = "(Optional) The Administrator login for the PostgreSQL Flexible Server. Required when create_mode is Default and authentication.password_auth_enabled is true."
}

variable "administrator_password" {
  type        = string
  description = "(Optional) The Password associated with the administrator_login for the PostgreSQL Flexible Server."
}

variable "database_config" {
  type        = list(map(string))
  description = "Specifies the Charset , Collation and database name for the PostgreSql Database. Changing this forces a new resource to be created."
  default     = []
}