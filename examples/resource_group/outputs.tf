output "name" {
  description = "The name of the resource group."
  value       = var.use_existing ? data.azurerm_resource_group.existing[0].name : azurerm_resource_group.this[0].name
}

output "id" {
  description = "The ID of the resource group."
  value       = var.use_existing ? data.azurerm_resource_group.existing[0].id : azurerm_resource_group.this[0].id
}

output "location" {
  description = "The location of the resource group."
  value       = var.use_existing ? data.azurerm_resource_group.existing[0].location : azurerm_resource_group.this[0].location
}