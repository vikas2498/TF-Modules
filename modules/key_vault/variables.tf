# ── Required Variables ──────────────────────────────────────────────────

variable "name" {
  description = "Specifies the name of the Key Vault. Must be globally unique, 3-24 characters, alphanumeric and hyphens."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9]$", var.name))
    error_message = "Key Vault name must be 3-24 characters, start with a letter, end with a letter or digit, and contain only alphanumeric characters and hyphens."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the Key Vault should exist."
  type        = string
}

# ── Optional Variables ──────────────────────────────────────────────────

variable "sku_name" {
  description = "(Optional) The Name of the SKU used for this Key Vault. Possible values are standard and premium. Defaults to standard."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "sku_name must be either 'standard' or 'premium'."
  }
}

variable "enabled_for_deployment" {
  description = "(Optional) Allow Azure Virtual Machines to retrieve certificates stored as secrets. Defaults to false."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "(Optional) Allow Azure Disk Encryption to retrieve secrets and unwrap keys. Defaults to true."
  type        = bool
  default     = true
}

variable "enabled_for_template_deployment" {
  description = "(Optional) Allow Azure Resource Manager to retrieve secrets. Defaults to false."
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "(Optional) Use RBAC for authorization of data actions instead of access policies. Defaults to false."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "(Optional) Number of days to retain soft-deleted items. Value must be between 7 and 90. Defaults to 90."
  type        = number
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "purge_protection_enabled" {
  description = "(Optional) Enable purge protection. Once enabled, it cannot be disabled. Defaults to false."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether public network access is allowed. Defaults to true."
  type        = bool
  default     = true
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# ── Access Policies ─────────────────────────────────────────────────────

variable "access_policies" {
  description = "(Optional) List of access policies for the Key Vault (up to 1024). Not used when enable_rbac_authorization is true."
  type = list(object({
    object_id               = string
    application_id          = optional(string)
    key_permissions         = optional(list(string), [])
    secret_permissions      = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
    storage_permissions     = optional(list(string), [])
  }))
  default = []
}

# ── Network ACLs ───────────────────────────────────────────────────────

variable "network_acls" {
  description = "(Optional) Network ACLs for the Key Vault."
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default = null
}

# ── Private Endpoint ───────────────────────────────────────────────────

variable "private_endpoint" {
  description = "(Optional) Private endpoint configuration for the Key Vault. Uses resource names (best practice) instead of IDs."
  type = object({
    name                         = string
    subnet_name                  = string
    virtual_network_name         = string
    subnet_resource_group_name   = optional(string)
    private_dns_zone_name        = optional(string)
    dns_zone_resource_group_name = optional(string)
  })
  default = null
}
