output "secret_ids" {
  description = "Map of Key Vault secret group keys to their secret IDs."
  value = {
    for k, v in module.key_vault_secrets : k => v.secret_ids
  }
}

output "secret_versionless_ids" {
  description = "Map of Key Vault secret group keys to their versionless secret IDs."
  value = {
    for k, v in module.key_vault_secrets : k => v.secret_versionless_ids
  }
}
