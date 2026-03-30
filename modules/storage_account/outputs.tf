output "id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "The name of the Storage Account."
  value       = azurerm_storage_account.this.name
}

output "primary_location" {
  description = "The primary location of the storage account."
  value       = azurerm_storage_account.this.primary_location
}

output "secondary_location" {
  description = "The secondary location of the storage account."
  value       = azurerm_storage_account.this.secondary_location
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "secondary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the secondary location."
  value       = azurerm_storage_account.this.secondary_blob_endpoint
}

output "primary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the primary location."
  value       = azurerm_storage_account.this.primary_queue_endpoint
}

output "primary_table_endpoint" {
  description = "The endpoint URL for table storage in the primary location."
  value       = azurerm_storage_account.this.primary_table_endpoint
}

output "primary_file_endpoint" {
  description = "The endpoint URL for file storage in the primary location."
  value       = azurerm_storage_account.this.primary_file_endpoint
}

output "primary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the primary location."
  value       = azurerm_storage_account.this.primary_dfs_endpoint
}

output "primary_web_endpoint" {
  description = "The endpoint URL for web storage in the primary location."
  value       = azurerm_storage_account.this.primary_web_endpoint
}

output "primary_access_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the storage account."
  value       = azurerm_storage_account.this.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The connection string associated with the primary location."
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The connection string associated with the secondary location."
  value       = azurerm_storage_account.this.secondary_connection_string
  sensitive   = true
}

output "primary_blob_connection_string" {
  description = "The connection string associated with the primary blob location."
  value       = azurerm_storage_account.this.primary_blob_connection_string
  sensitive   = true
}

output "identity" {
  description = "The identity block of the storage account."
  value       = azurerm_storage_account.this.identity
}

output "container_ids" {
  description = "Map of container names to their IDs."
  value = {
    for k, v in azurerm_storage_container.this : k => v.id
  }
}

output "container_resource_manager_ids" {
  description = "Map of container names to their Resource Manager IDs."
  value = {
    for k, v in azurerm_storage_container.this : k => v.resource_manager_id
  }
}

output "file_share_ids" {
  description = "Map of file share names to their IDs."
  value = {
    for k, v in azurerm_storage_share.this : k => v.id
  }
}

output "file_share_resource_manager_ids" {
  description = "Map of file share names to their Resource Manager IDs."
  value = {
    for k, v in azurerm_storage_share.this : k => v.resource_manager_id
  }
}

output "file_share_urls" {
  description = "Map of file share names to their URLs."
  value = {
    for k, v in azurerm_storage_share.this : k => v.url
  }
}

output "private_endpoint_ids" {
  description = "Map of private endpoint keys to their IDs."
  value = {
    for k, v in azurerm_private_endpoint.this : k => v.id
  }
}

output "private_endpoint_ip_addresses" {
  description = "Map of private endpoint keys to their private IP addresses."
  value = {
    for k, v in azurerm_private_endpoint.this : k => v.private_service_connection[0].private_ip_address
  }
}
