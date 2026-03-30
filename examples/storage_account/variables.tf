variable "storage_accounts" {
  description = "Map of storage accounts to create."

  type = map(object({
    name                             = string
    resource_group_name              = string
    location                         = string
    account_tier                     = string
    account_replication_type         = string
    account_kind                     = optional(string, "StorageV2")
    access_tier                      = optional(string, "Hot")
    cross_tenant_replication_enabled = optional(bool, false)
    edge_zone                        = optional(string)
    https_traffic_only_enabled       = optional(bool, true)
    min_tls_version                  = optional(string, "TLS1_2")
    allow_nested_items_to_be_public  = optional(bool, false)
    shared_access_key_enabled        = optional(bool, true)
    public_network_access_enabled    = optional(bool, true)
    default_to_oauth_authentication  = optional(bool, false)
    is_hns_enabled                   = optional(bool, false)
    nfsv3_enabled                    = optional(bool, false)
    large_file_share_enabled         = optional(bool, false)
    local_user_enabled               = optional(bool, true)
    queue_encryption_key_type        = optional(string, "Service")
    table_encryption_key_type        = optional(string, "Service")
    infrastructure_encryption_enabled = optional(bool, false)
    allowed_copy_scope               = optional(string)
    sftp_enabled                     = optional(bool, false)
    dns_endpoint_type                = optional(string, "Standard")
    tags                             = optional(map(string), {})

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))

    customer_managed_key = optional(object({
      key_vault_key_id          = optional(string)
      user_assigned_identity_id = string
    }))

    network_rules = optional(object({
      default_action             = string
      bypass                     = optional(list(string), ["AzureServices"])
      ip_rules                   = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
      private_link_access = optional(list(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = optional(string)
      })))
    }))

    blob_properties = optional(object({
      versioning_enabled            = optional(bool, false)
      change_feed_enabled           = optional(bool, false)
      change_feed_retention_in_days = optional(number)
      default_service_version       = optional(string)
      last_access_time_enabled      = optional(bool, false)
      delete_retention_policy = optional(object({
        days                     = optional(number, 7)
        permanent_delete_enabled = optional(bool, false)
      }))
      restore_policy = optional(object({
        days = number
      }))
      container_delete_retention_policy = optional(object({
        days = optional(number, 7)
      }))
      cors_rules = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
    }))

    queue_properties = optional(object({
      logging = optional(object({
        delete                = bool
        read                  = bool
        version               = string
        write                 = bool
        retention_policy_days = optional(number)
      }))
      hour_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))
      minute_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))
      cors_rules = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
    }))

    share_properties = optional(object({
      retention_policy = optional(object({
        days = optional(number, 7)
      }))
      smb = optional(object({
        versions                        = optional(set(string))
        authentication_types            = optional(set(string))
        kerberos_ticket_encryption_type = optional(set(string))
        channel_encryption_type         = optional(set(string))
        multichannel_enabled            = optional(bool, false)
      }))
      cors_rules = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
    }))

    static_website = optional(object({
      index_document     = optional(string)
      error_404_document = optional(string)
    }))

    azure_files_authentication = optional(object({
      directory_type               = string
      default_share_level_permission = optional(string, "None")
      active_directory = optional(object({
        domain_name         = string
        domain_guid         = string
        domain_sid          = optional(string)
        storage_sid         = optional(string)
        forest_name         = optional(string)
        netbios_domain_name = optional(string)
      }))
    }))

    routing = optional(object({
      publish_internet_endpoints  = optional(bool, false)
      publish_microsoft_endpoints = optional(bool, false)
      choice                      = optional(string, "MicrosoftRouting")
    }))

    immutability_policy = optional(object({
      allow_protected_append_writes = bool
      state                         = string
      period_since_creation_in_days = number
    }))

    sas_policy = optional(object({
      expiration_period = string
      expiration_action = optional(string, "Log")
    }))

    containers = optional(map(object({
      container_access_type             = optional(string, "private")
      default_encryption_scope          = optional(string)
      encryption_scope_override_enabled = optional(bool, true)
      metadata                          = optional(map(string))
      private_endpoint = optional(object({
        name                         = string
        subnet_name                  = string
        virtual_network_name         = string
        subnet_resource_group_name   = optional(string)
        subresource_names            = optional(list(string), ["blob"])
        private_dns_zone_name        = optional(string)
        dns_zone_resource_group_name = optional(string)
      }))
    })), {})

    file_shares = optional(map(object({
      quota            = number
      access_tier      = optional(string)
      enabled_protocol = optional(string, "SMB")
      metadata         = optional(map(string))
      acl = optional(list(object({
        id = string
        access_policy = optional(object({
          permissions = string
          start       = optional(string)
          expiry      = optional(string)
        }))
      })))
      private_endpoint = optional(object({
        name                         = string
        subnet_name                  = string
        virtual_network_name         = string
        subnet_resource_group_name   = optional(string)
        subresource_names            = optional(list(string), ["file"])
        private_dns_zone_name        = optional(string)
        dns_zone_resource_group_name = optional(string)
      }))
    })), {})
  }))
}
