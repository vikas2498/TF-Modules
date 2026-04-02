key_vaults = {
  platform = {
    name                        = "sub200weudevkv01"
    resource_group_name         = "sub-200-weu-dev-rg-net"
    location                    = "West Europe"
    sku_name                    = "standard"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    access_policies = [
      {
        object_id          = "00000000-0000-0000-0000-000000000000" # replace with your user/SP object ID
        key_permissions    = ["Get", "List", "Create", "Delete", "Backup", "Restore"]
        secret_permissions = ["Get", "List", "Set", "Delete", "Backup", "Restore"]
      }
    ]
    network_acls = {
      bypass         = "AzureServices"
      default_action = "Deny"
      ip_rules       = ["100.0.0.1"]
    }
    private_endpoint = {
      name                         = "sub200weudevkv01-pe"
      subnet_name                  = "sub-200-weu-dev-pe-snt"
      virtual_network_name         = "sub-200-weu-dev-vnet"
      subnet_resource_group_name   = "sub-200-weu-dev-rg-net"
      private_dns_zone_name        = "privatelink.vaults.azure.net"
      dns_zone_resource_group_name = "sub-200-weu-dev-rg-net"
    }
    tags = {
      project     = "Platform"
      environment = "Dev"
      WBS         = "200"
    }
  }
}
