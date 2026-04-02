output "key_vault_ids" {
  description = "Map of Key Vault keys to their IDs."
  value = {
    for k, v in module.key_vaults : k => v.id
  }
}

output "key_vault_uris" {
  description = "Map of Key Vault keys to their URIs."
  value = {
    for k, v in module.key_vaults : k => v.vault_uri
  }
}
