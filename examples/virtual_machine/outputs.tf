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