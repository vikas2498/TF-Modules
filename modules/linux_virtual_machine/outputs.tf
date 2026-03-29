/*
# Linux Virtual Machine Outputs

This Terraform module outputs configuration details for an Azure Linux virtual machine resource.

## Output Variables

- **vm_id**: The unique identifier of the provisioned Linux virtual machine.
- **vm_name**: The assigned name of the Linux virtual machine.
- **vm_private_ip**: The primary private IP address allocated to the virtual machine within the virtual network.
- **vm_public_ip**: The public IP address associated with the virtual machine, if one has been assigned.
- **vm_identity**: The managed identity configuration block attached to the virtual machine, containing identity type and principal ID information.

These outputs enable consuming modules and root configurations to reference and utilize the deployed virtual machine's properties for downstream resource creation and configuration.
*/
output "vm_id" {
  description = "The ID of the Linux virtual machine."
  value       = azurerm_linux_virtual_machine.this.id
}

output "vm_name" {
  description = "The name of the Linux virtual machine."
  value       = azurerm_linux_virtual_machine.this.name
}

output "vm_private_ip" {
  description = "The primary private IP address of the virtual machine."
  value       = azurerm_linux_virtual_machine.this.private_ip_address
}

output "vm_public_ip" {
  description = "The public IP address of the virtual machine if assigned."
  value       = azurerm_linux_virtual_machine.this.public_ip_address
}

output "vm_identity" {
  description = "The identity block of the virtual machine."
  value       = azurerm_linux_virtual_machine.this.identity
}