terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.22.0"
    }
  }
}

data "azurerm_subscription" "current" {
  subscription_id = var.subscription_id
}

resource "azurerm_network_security_group" "default" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_virtual_network" "default" {
  depends_on = [ azurerm_network_security_group.default ]

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
  depends_on = [ azurerm_virtual_network.default ]
  for_each = {
    for subnet in var.subnets: subnet.name => subnet
  }

  name                  = each.value.name
  resource_group_name   = var.resource_group
  virtual_network_name  = azurerm_virtual_network.default.name
  address_prefixes      = each.value.address_prefixes
  dynamic delegation {
    for_each = (length(each.value.delegation_name) > 0 && length(each.value.delegation_action) > 0) ? {""=""} : {}
    content {
      name = "${each.value.name}-delegation"
      service_delegation {
        name    = each.value.delegation_name
        actions = split(",", each.value.delegation_action)
      }
    }
  }
}

