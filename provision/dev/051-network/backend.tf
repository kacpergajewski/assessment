terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-rg"
    storage_account_name  = "kacpergajewskiterraform"
    container_name        = "dev"
    key                   = "dev.network.tfstate"
  }
}