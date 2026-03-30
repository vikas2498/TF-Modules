storage_accounts = {
  tfstate = {
    name                     = "devtfstatestgacc"
    resource_group_name      = "EA-WE-D-RG-D03"
    location                 = "West Europe"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    containers = {
      "devtfstatestgacc-cont" = {
        container_access_type = "private"
      }
    }
    tags = {
      project     = "Platform"
      environment = "Dev"
      SID         = "D03"
    }
  }

  app = {
    name                     = "devappstgacc"
    resource_group_name      = "EA-WE-D-RG-D04"
    location                 = "West Europe"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    blob_properties = {
      versioning_enabled = true
      delete_retention_policy = {
        days = 7
      }
      container_delete_retention_policy = {
        days = 7
      }
    }
    network_rules = {
      default_action = "Deny"
      bypass         = ["AzureServices"]
      ip_rules       = ["100.0.0.1"]
    }
    containers = {
      "app-data" = {
        container_access_type = "private"
        private_endpoint = {
          name                         = "devappstgacc-appdata-pe"
          subnet_name                  = "pe-snet"
          virtual_network_name         = "EA-WE-D-VNet"
          subnet_resource_group_name   = "EA-WE-D-RG-Net"
          subresource_names            = ["blob"]
          private_dns_zone_name        = "privatelink.blob.core.windows.net"
          dns_zone_resource_group_name = "EA-WE-D-RG-Net"
        }
      }
      "app-logs" = {
        container_access_type = "private"
        private_endpoint = {
          name                         = "devappstgacc-applogs-pe"
          subnet_name                  = "pe-snet"
          virtual_network_name         = "EA-WE-D-VNet"
          subnet_resource_group_name   = "EA-WE-D-RG-Net"
          subresource_names            = ["blob"]
          private_dns_zone_name        = "privatelink.blob.core.windows.net"
          dns_zone_resource_group_name = "EA-WE-D-RG-Net"
        }
      }
    }
    file_shares = {
      "app-share" = {
        quota       = 50
        access_tier = "Hot"
        private_endpoint = {
          name                         = "devappstgacc-appshare-pe"
          subnet_name                  = "pe-snet"
          virtual_network_name         = "EA-WE-D-VNet"
          subnet_resource_group_name   = "EA-WE-D-RG-Net"
          subresource_names            = ["file"]
          private_dns_zone_name        = "privatelink.file.core.windows.net"
          dns_zone_resource_group_name = "EA-WE-D-RG-Net"
        }
      }
    }
    tags = {
      project     = "Platform"
      environment = "Dev"
      SID         = "D04"
    }
  }
}
