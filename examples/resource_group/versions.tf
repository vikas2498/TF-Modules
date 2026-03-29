/*
This Terraform configuration specifies the required version of Terraform and the AzureRM provider.

- `terraform` block:
    - `required_version`: Ensures that Terraform version 1.3.0 or higher is used.
    - `required_providers`: Specifies the AzureRM provider with a version constraint of "~> 3.0", ensuring compatibility with version 3.x.

- `provider "azurerm"` block:
    - Configures the AzureRM provider with default features.

This configuration is typically used as a foundational setup for managing Azure resources using Terraform.
*/

terraform {
    required_version = ">= 1.3.0"

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.0"
        }
    }
}

provider "azurerm"{
    features {}
}