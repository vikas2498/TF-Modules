terraform {
  backend "azurerm" {
    key                  = "key_vault/terraform.tfstate"
    storage_account_name = "devtfstatestgacc"
    resource_group_name  = "dev-tfstate-rg"
    container_name       = "devtfstatestgacc-cont"
  }
}
