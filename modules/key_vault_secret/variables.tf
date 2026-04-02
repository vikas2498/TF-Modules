# ── Required Variables ──────────────────────────────────────────────────

variable "key_vault_name" {
  description = "The name of the Key Vault where secrets should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group containing the Key Vault."
  type        = string
}

# ── Secrets ────────────────────────────────────────────────────────────

variable "secrets" {
  description = "Map of secrets to create in the Key Vault. Each key is a logical identifier, and the value defines the secret's properties."
  sensitive   = true

  type = map(object({
    name            = string
    value           = string
    content_type    = optional(string)
    not_before_date = optional(string)
    expiration_date = optional(string)
    tags            = optional(map(string), {})
  }))
  default = {}
}

# ── Optional Variables ─────────────────────────────────────────────────

variable "tags" {
  description = "(Optional) A mapping of tags to assign to all secrets."
  type        = map(string)
  default     = {}
}
