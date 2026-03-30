# ── Required Variables ──────────────────────────────────────────────────

variable "name" {
  description = "Specifies the name of the storage account. Only lowercase alphanumeric characters allowed. Must be unique across Azure."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "Storage account name must be 3-24 characters long and contain only lowercase letters and numbers."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium."
  type        = string

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = "Defines the type of replication to use. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type        = string

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "account_replication_type must be one of: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

# ── Optional Variables ──────────────────────────────────────────────────

variable "account_kind" {
  description = "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2."
  type        = string
  default     = "StorageV2"

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "account_kind must be one of: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2."
  }
}

variable "access_tier" {
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot, Cool and Cold. Defaults to Hot."
  type        = string
  default     = "Hot"

  validation {
    condition     = contains(["Hot", "Cool", "Cold"], var.access_tier)
    error_message = "access_tier must be one of: Hot, Cool, Cold."
  }
}

variable "cross_tenant_replication_enabled" {
  description = "(Optional) Should cross Tenant replication be enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist."
  type        = string
  default     = null
}

variable "https_traffic_only_enabled" {
  description = "(Optional) Forces HTTPS if enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "(Optional) The minimum supported TLS version. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2."
  type        = string
  default     = "TLS1_2"

  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "min_tls_version must be one of: TLS1_0, TLS1_1, TLS1_2."
  }
}

variable "allow_nested_items_to_be_public" {
  description = "(Optional) Allow or disallow nested items within this Account to opt into being public. Defaults to false."
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "(Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. Defaults to true."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether the public network access is enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "(Optional) Default to Azure Active Directory authorization in the Azure portal. Defaults to false."
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "(Optional) Is Hierarchical Namespace enabled? Used with Azure Data Lake Storage Gen 2. Defaults to false."
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  description = "(Optional) Is NFSv3 protocol enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "(Optional) Are Large File Shares Enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "local_user_enabled" {
  description = "(Optional) Is Local User Enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "queue_encryption_key_type" {
  description = "(Optional) The encryption type of the queue service. Possible values are Service and Account. Defaults to Service."
  type        = string
  default     = "Service"

  validation {
    condition     = contains(["Service", "Account"], var.queue_encryption_key_type)
    error_message = "queue_encryption_key_type must be either 'Service' or 'Account'."
  }
}

variable "table_encryption_key_type" {
  description = "(Optional) The encryption type of the table service. Possible values are Service and Account. Defaults to Service."
  type        = string
  default     = "Service"

  validation {
    condition     = contains(["Service", "Account"], var.table_encryption_key_type)
    error_message = "table_encryption_key_type must be either 'Service' or 'Account'."
  }
}

variable "infrastructure_encryption_enabled" {
  description = "(Optional) Is infrastructure encryption enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "allowed_copy_scope" {
  description = "(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links. Possible values are AAD and PrivateLink."
  type        = string
  default     = null

  validation {
    condition     = var.allowed_copy_scope == null ? true : contains(["AAD", "PrivateLink"], var.allowed_copy_scope)
    error_message = "allowed_copy_scope must be either 'AAD' or 'PrivateLink'."
  }
}

variable "sftp_enabled" {
  description = "(Optional) Is SFTP enabled for the storage account? Defaults to false."
  type        = bool
  default     = false
}

variable "dns_endpoint_type" {
  description = "(Optional) Specifies which DNS endpoint type to use. Possible values are Standard and AzureDnsZone. Defaults to Standard."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "AzureDnsZone"], var.dns_endpoint_type)
    error_message = "dns_endpoint_type must be either 'Standard' or 'AzureDnsZone'."
  }
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# ── Block Variables ─────────────────────────────────────────────────────

variable "identity" {
  description = "(Optional) An identity block for Managed Service Identity."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "custom_domain" {
  description = "(Optional) A custom_domain block."
  type = object({
    name          = string
    use_subdomain = optional(bool)
  })
  default = null
}

variable "customer_managed_key" {
  description = "(Optional) A customer_managed_key block."
  type = object({
    key_vault_key_id          = optional(string)
    user_assigned_identity_id = string
  })
  default = null
}

variable "network_rules" {
  description = "(Optional) A network_rules block."
  type = object({
    default_action             = string
    bypass                     = optional(list(string), ["AzureServices"])
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })))
  })
  default = null
}

variable "blob_properties" {
  description = "(Optional) A blob_properties block."
  type = object({
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
  })
  default = null
}

variable "queue_properties" {
  description = "(Optional) A queue_properties block. Only supported when account_tier is Standard and account_kind is Storage or StorageV2."
  type = object({
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
  })
  default = null
}

variable "share_properties" {
  description = "(Optional) A share_properties block."
  type = object({
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
  })
  default = null
}

variable "static_website" {
  description = "(Optional) A static_website block. Only supported when account_kind is StorageV2 or BlockBlobStorage."
  type = object({
    index_document     = optional(string)
    error_404_document = optional(string)
  })
  default = null
}

variable "azure_files_authentication" {
  description = "(Optional) An azure_files_authentication block."
  type = object({
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
  })
  default = null
}

variable "routing" {
  description = "(Optional) A routing block."
  type = object({
    publish_internet_endpoints  = optional(bool, false)
    publish_microsoft_endpoints = optional(bool, false)
    choice                      = optional(string, "MicrosoftRouting")
  })
  default = null
}

variable "immutability_policy" {
  description = "(Optional) An immutability_policy block."
  type = object({
    allow_protected_append_writes = bool
    state                         = string
    period_since_creation_in_days = number
  })
  default = null
}

variable "sas_policy" {
  description = "(Optional) A sas_policy block."
  type = object({
    expiration_period = string
    expiration_action = optional(string, "Log")
  })
  default = null
}

# ── Sub-Resources ───────────────────────────────────────────────────────

variable "containers" {
  description = "(Optional) Map of storage containers to create. The map key is the container name. Each container can optionally have its own private endpoint."
  type = map(object({
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
  }))
  default = {}
}

variable "file_shares" {
  description = "(Optional) Map of file shares to create. The map key is the share name. Each share can optionally have its own private endpoint."
  type = map(object({
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
  }))
  default = {}
}
