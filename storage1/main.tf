terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
    backend "azurerm" {
        subscription_id      = "a171e7f2-6816-40c9-bff3-07d6feaf1b4a"
        resource_group_name  = azurerm_resource_group.state-rg.name
        storage_account_name = azurerm_storage_account.state-sta.name
        container_name       = azurerm_storage_container.core-container.name
        key                  = "terraform.tfstate"
    }

}
provider "azurerm" {
  features {}
}
# Generate a random storage name
resource "random_string" "tf-name" {
  length = 8
  upper = false
  number = true
  lower = true
  special = false
}
# Create a Resource Group for the Terraform State File
resource "azurerm_resource_group" "state-rg" {
  name = "storage-tfstate-rg"
  location = "East US"

  lifecycle {
    prevent_destroy = true
  }
}
# Create a Storage Account for the Terraform State File
resource "azurerm_storage_account" "state-sta" {
  depends_on = [azurerm_resource_group.state-rg]
  name = "storagetfstate4972"
  resource_group_name = azurerm_resource_group.state-rg.name
  location = azurerm_resource_group.state-rg.location
  account_kind = "StorageV2"
  account_tier = "Standard"
  access_tier = "Hot"
  account_replication_type = "ZRS"
  enable_https_traffic_only = true

  lifecycle {
    prevent_destroy = true
  }
}
# Create a Storage Container for the Core State File
resource "azurerm_storage_container" "core-container" {
  depends_on = [azurerm_storage_account.state-sta]
  name = "core-tfstate"
  storage_account_name = azurerm_storage_account.state-sta.name
}