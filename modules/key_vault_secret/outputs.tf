output "secret_ids" {
  description = "Map of secret keys to their IDs (versioned)."
  value = {
    for k, v in azurerm_key_vault_secret.this : k => v.id
  }
}

output "secret_versionless_ids" {
  description = "Map of secret keys to their versionless IDs (auto-rotates)."
  value = {
    for k, v in azurerm_key_vault_secret.this : k => v.versionless_id
  }
}

output "secret_versions" {
  description = "Map of secret keys to their current version."
  value = {
    for k, v in azurerm_key_vault_secret.this : k => v.version
  }
}

output "secret_resource_ids" {
  description = "Map of secret keys to their versioned resource IDs."
  value = {
    for k, v in azurerm_key_vault_secret.this : k => v.resource_id
  }
}

output "secret_resource_versionless_ids" {
  description = "Map of secret keys to their versionless resource IDs."
  value = {
    for k, v in azurerm_key_vault_secret.this : k => v.resource_versionless_id
  }
}

output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = data.azurerm_key_vault.this.id
}
