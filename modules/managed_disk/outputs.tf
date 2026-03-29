output "id" {
  description = "The ID of the managed disk."
  value       = azurerm_managed_disk.this.id
}

output "name" {
  description = "The name of the managed disk."
  value       = azurerm_managed_disk.this.name
}

output "disk_size_gb" {
  description = "The size of the managed disk in GB."
  value       = azurerm_managed_disk.this.disk_size_gb
}