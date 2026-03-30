# Outputs

## resource_group_ids
## - **Description**: Map of key → resource ID for every resource group created.
## - **Value**: A map where the key is the identifier and the value is the resource ID of the resource group.

## resource_group_names
## - **Description**: Map of key → name for every resource group created.
## - **Value**: A map where the key is the identifier and the value is the name of the resource group.

## resource_group_location
## - **Description**: Map of key → Azure region for every resource group created.
## - **Value**: A map where the key is the identifier and the value is the Azure region of the resource group.

output "resource_group_ids" {
    description = "Map of key → resource ID for every resource group created."
    value       = { 
        for k, v in module.resource_groups : k => v.id 
        }
}

output "resource_group_names" {
    description = "Map of key → name for every resource group created."
    value       = {
        for k, v in module.resource_groups : k =>v.name
        }
}

output "resource_group_location" {
    description = "Map of key → Azure region for every resource group created."
    value       ={
        for k, v in module.resource_groups : k =>v.location
    } 
}