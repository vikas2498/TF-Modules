variable "key_vaults" {
  description = "Map of Key Vaults to create."

  type = map(object({
    name                            = string
    resource_group_name             = string
    location                        = string
    sku_name                        = optional(string, "standard")
    enabled_for_deployment          = optional(bool, false)
    enabled_for_disk_encryption     = optional(bool, true)
    enabled_for_template_deployment = optional(bool, false)
    enable_rbac_authorization       = optional(bool, false)
    soft_delete_retention_days      = optional(number, 90)
    purge_protection_enabled        = optional(bool, false)
    public_network_access_enabled   = optional(bool, true)
    tags                            = optional(map(string), {})

    access_policies = optional(list(object({
      object_id               = string
      application_id          = optional(string)
      key_permissions         = optional(list(string), [])
      secret_permissions      = optional(list(string), [])
      certificate_permissions = optional(list(string), [])
      storage_permissions     = optional(list(string), [])
    })), [])

    network_acls = optional(object({
      bypass                     = string
      default_action             = string
      ip_rules                   = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
    }))

    private_endpoint = optional(object({
      name                         = string
      subnet_name                  = string
      virtual_network_name         = string
      subnet_resource_group_name   = optional(string)
      private_dns_zone_name        = optional(string)
      dns_zone_resource_group_name = optional(string)
    }))
  }))
}
