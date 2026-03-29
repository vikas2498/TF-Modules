/*
 * This Terraform configuration defines the backend settings for storing the Terraform state file in Azure Storage.
 * 
 * - `key`: Specifies the name of the state file to be stored in the backend.
 * - `storage_account_name`: The name of the Azure Storage Account where the state file will be stored.
 * - `resource_group_name`: The name of the Azure Resource Group containing the storage account.
 * - `container_name`: The name of the container within the storage account where the state file will be stored.
 * 
 * This configuration ensures that the Terraform state is stored remotely in a secure and centralized location.
 */
terraform {
  backend "azurerm" {
    key                  = "linux_vm/terraform.tfstate"
    storage_account_name = "devtfstatestgacc"
    resource_group_name  = "dev-tfstate-rg"
    container_name       = "devtfstatestgacc-cont"
  }
}