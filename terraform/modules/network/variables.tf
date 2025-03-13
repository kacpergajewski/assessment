variable "subscription_id" {
  type        = string
  description = "ID of the subscription where the resource will be deployed"
}

variable "location" {
  type        = string
  default     = "Poland Central"
  description = "Location for the resources. Changing this forces a new resource to be created"
}

variable "resource_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the resource"
}


variable "name" {
  type        = string
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
}

variable "resource_group" {
  type        = string
  description = "(Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
}

variable "address_space" {
  type        = list(string)
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
}

variable "subnets" {
  type = list(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = list(string)
    delegation_name   = string
    delegation_action = string
  }))
  default     = []
  description = "List of subnet name and address prefix"
}