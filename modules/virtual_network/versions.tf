# Terraform Version Configuration
# Specifies the minimum Terraform version requirement and required providers for the virtual network module.
# - Requires Terraform >= 1.3.0
# - Uses Azure Resource Manager (azurerm) provider version ~> 3.0 from HashiCorp

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
