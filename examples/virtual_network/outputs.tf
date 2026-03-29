# Outputs Documentation

# This file defines the output values for the virtual network module examples.

## Output Descriptions

# virtual_network_ids**: Returns a map where keys correspond to virtual network module instances and values are their respective resource IDs. This allows consumers to reference the created virtual networks by their identifier.

# virtual_network_names**: Returns a map where keys correspond to virtual network module instances and values are their respective names. Useful for referencing virtual networks by name in downstream configurations.

# subnet_ids**: Returns a nested map structure where the top-level keys correspond to virtual network module instances, and each value is a map of subnet names to their respective subnet IDs. This provides detailed subnet information for all subnets created within each virtual network.

## Usage

#These outputs enable callers of this module to access and reference the identifiers and names of created Azure virtual networks and their subnets for use in other Terraform configurations or for direct consumption.

output "virtual_network_ids" {
  description = "Map of key → resource ID for every virtual network created."
  value       = { for k, v in module.virtual_network : k => v.virtual_network_id }
}

output "virtual_network_names" {
  description = "Map of key → name for every virtual network created."
  value       = { for k, v in module.virtual_network : k => v.virtual_network_name }
}

output "subnet_ids" {
  description = "Map of key → subnet name → subnet ID for every virtual network created."
  value       = { for k, v in module.virtual_network : k => v.subnet_ids }
}