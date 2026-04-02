output "id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.this.name
}

output "vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.this.vault_uri
}

output "tenant_id" {
  description = "The Azure AD tenant ID used by the Key Vault."
  value       = azurerm_key_vault.this.tenant_id
}

output "private_endpoint_id" {
  description = "The ID of the private endpoint, if created."
  value       = try(azurerm_private_endpoint.this[0].id, null)
}

output "private_endpoint_ip_address" {
  description = "The private IP address of the private endpoint, if created."
  value       = try(azurerm_private_endpoint.this[0].private_service_connection[0].private_ip_address, null)
}
