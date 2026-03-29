# Outputs

# This module exports the following outputs for the virtual network and its subnets:

# virtual_network_id**: The ID of the created virtual network, useful for referencing the network in other resources.
# virtual_network_name**: The name of the created virtual network for identification and logging purposes.
# subnets**: A complete map of all created subnet objects containing their full configuration details.
# subnet_ids**: A convenient map that associates subnet names with their corresponding IDs for easy reference in dependent resources.

output "virtual_network_id" {
  description = "The ID of the created virtual network."
  value       = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  description = "The name of the created virtual network."
  value       = azurerm_virtual_network.this.name
}

output "subnets" {
  description = "A map of the created subnets."
  value       = azurerm_subnet.this
}

output "subnet_ids" {
  description = "A map of subnet names to their IDs."
  value = {
    for k, v in azurerm_subnet.this : k => v.id
  }
}