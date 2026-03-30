output "storage_account_ids" {
  description = "Map of key → resource ID for every storage account created."
  value = {
    for k, v in module.storage_accounts : k => v.id
  }
}

output "storage_account_names" {
  description = "Map of key → name for every storage account created."
  value = {
    for k, v in module.storage_accounts : k => v.name
  }
}

output "storage_account_primary_blob_endpoints" {
  description = "Map of key → primary blob endpoint for every storage account created."
  value = {
    for k, v in module.storage_accounts : k => v.primary_blob_endpoint
  }
}

output "storage_account_primary_web_endpoints" {
  description = "Map of key → primary web endpoint for every storage account created."
  value = {
    for k, v in module.storage_accounts : k => v.primary_web_endpoint
  }
}
