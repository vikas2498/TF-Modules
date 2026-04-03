key_vaults = {
  platform = {
    name                        = "AQA-INF-PRD-EUW-IO-KV"
    resource_group_name         = "EA-WE-D-RG-D03"
    location                    = "West Europe"
    sku_name                    = "standard"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    access_policies = [
      {
        object_id          = "974a022a-fa9e-427e-91b7-367088441400" # replace with your user/SP object ID
        key_permissions    = ["Get", "List", "Create", "Delete", "Backup", "Restore"]
        secret_permissions = ["Get", "List", "Set", "Delete", "Backup", "Restore"]
      }
    ]
   /*
    network_acls = {
      bypass         = "AzureServices"
      default_action = "Deny"
      ip_rules       = ["100.0.0.1"]
    }
    */
    private_endpoint = {
      name                         = "AQA-INF-PRD-EUW-IO-KV-pe"
      subnet_name                  = "EA-WE-prd-app-snet"
      virtual_network_name         = "EA-WE-prd-Vnet"
      subnet_resource_group_name   = "EA-WE-D-RG-Net"
     # private_dns_zone_name        = "privatelink.vaults.azure.net"
     # dns_zone_resource_group_name = "sub-200-weu-dev-rg-net"
    }
    tags = {
      project     = "Platform"
      environment = "Dev"
      WBS         = "200"
    }
  }
}
