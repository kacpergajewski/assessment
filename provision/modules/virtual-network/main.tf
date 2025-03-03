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

resource "azurerm_network_security_group" "default" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_virtual_network" "default" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = var.address_space

  tags = var.resource_tags

  lifecycle {
    ignore_changes = [
      tags,
      location
    ]
  }
}

resource "azurerm_subnet" "default" {
  for_each = {
    for subnet in var.subnets: subnet.name => subnet
  }

  name                 = each.value.subnet
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = each.value.address_prefix
}

