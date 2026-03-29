output "id"{
    description = "The fully qualified resource ID of the resource group."
    value       = azurerm_resource_group.this.id
}

output "name" {
    description = "The name of the resource group."
    value       = azurerm_resource_group.this.name
}

output "location" {
    description = "The Azure region in which the resource group was created."
    value       = azurerm_resource_group.this.location
    
}