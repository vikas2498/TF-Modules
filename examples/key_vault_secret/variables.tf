variable "key_vault_secrets" {
  description = "Map of Key Vault secret groups to create. Each entry targets a Key Vault by name and contains a map of secrets."
  sensitive   = true

  type = map(object({
    key_vault_name      = string
    resource_group_name = string
    tags                = optional(map(string), {})

    secrets = optional(map(object({
      name            = string
      value           = string
      content_type    = optional(string)
      not_before_date = optional(string)
      expiration_date = optional(string)
      tags            = optional(map(string), {})
    })), {})
  }))
}
