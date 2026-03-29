/*
# Virtual Machine Outputs

This Terraform outputs file exports resource identifiers and networking information for both Linux and Windows virtual machines deployed through their respective modules.

## Linux VM Outputs

- **linux_vm_ids**: Exports a map of VM identifiers for all created Linux virtual machines, keyed by their configuration names for easy reference.
- **linux_vm_private_ips**: Exports a map of private IP addresses for all Linux VMs, enabling internal networking configuration and reference.
- **linux_nic_ids**: Exports a map of network interface controller (NIC) IDs for all Linux VMs, useful for network configuration and security group associations.
- **linux_data_disk_ids**: Exports a map of managed disk identifiers for all data disks attached to Linux VMs, supporting storage management operations.

## Windows VM Outputs

- **windows_vm_ids**: Exports a map of VM identifiers for all created Windows virtual machines, keyed by their configuration names.
- **windows_vm_private_ips**: Exports a map of private IP addresses for all Windows VMs, facilitating internal network connectivity and domain integration.
- **windows_nic_ids**: Exports a map of network interface controller (NIC) IDs for all Windows VMs, supporting network configuration and RDP access setup.
- **windows_data_disk_ids**: Exports a map of managed disk identifiers for all data disks attached to Windows VMs, enabling storage and backup operations.

## Usage

These outputs are designed to be consumed by downstream Terraform modules or external systems that need to reference created infrastructure resources. All outputs use map structures keyed by the module instance names for flexible multi-environment deployments.
*/
# ── Linux VM Outputs ───────────────────────────────────────────────────
output "linux_vm_ids" {
  description = "Map of key → VM ID for every Linux virtual machine created."
  value       = { for k, v in module.linux_virtual_machine : k => v.vm_id }
}

output "linux_vm_private_ips" {
  description = "Map of key → private IP for every Linux virtual machine created."
  value       = { for k, v in module.linux_virtual_machine : k => v.vm_private_ip }
}

output "linux_nic_ids" {
  description = "Map of key → NIC ID for every Linux virtual machine."
  value       = { for k, v in module.linux_nic : k => v.id }
}

output "linux_data_disk_ids" {
  description = "Map of key → data disk ID for every Linux managed disk created."
  value       = { for k, v in module.linux_managed_disk : k => v.id }
}

# ── Windows VM Outputs ─────────────────────────────────────────────────
output "windows_vm_ids" {
  description = "Map of key → VM ID for every Windows virtual machine created."
  value       = { for k, v in module.windows_virtual_machine : k => v.vm_id }
}

output "windows_vm_private_ips" {
  description = "Map of key → private IP for every Windows virtual machine created."
  value       = { for k, v in module.windows_virtual_machine : k => v.vm_private_ip }
}

output "windows_nic_ids" {
  description = "Map of key → NIC ID for every Windows virtual machine."
  value       = { for k, v in module.windows_nic : k => v.id }
}

output "windows_data_disk_ids" {
  description = "Map of key → data disk ID for every Windows managed disk created."
  value       = { for k, v in module.windows_managed_disk : k => v.id }
}