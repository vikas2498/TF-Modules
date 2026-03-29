output "vm_id" {
  description = "The ID of the Windows virtual machine."
  value       = azurerm_windows_virtual_machine.this.id
}

output "vm_name" {
  description = "The name of the Windows virtual machine."
  value       = azurerm_windows_virtual_machine.this.name
}

output "vm_private_ip" {
  description = "The primary private IP address of the virtual machine."
  value       = azurerm_windows_virtual_machine.this.private_ip_address
}

output "vm_public_ip" {
  description = "The public IP address of the virtual machine if assigned."
  value       = azurerm_windows_virtual_machine.this.public_ip_address
}

output "vm_identity" {
  description = "The identity block of the virtual machine."
  value       = azurerm_windows_virtual_machine.this.identity
}