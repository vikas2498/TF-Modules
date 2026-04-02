key_vault_secrets = {
  platform = {
    key_vault_name      = "sub200weudevkv01"
    resource_group_name = "sub-200-weu-dev-rg-net"

    secrets = {
      db-connection-string = {
        name         = "db-connection-string"
        value        = "Server=myserver.database.windows.net;Database=mydb;"
        content_type = "text/plain"
        expiration_date = "2027-12-31T23:59:59Z"
        tags = {
          purpose = "database"
        }
      }
      api-key = {
        name            = "api-key"
        value           = "super-secret-api-key-value"
        content_type    = "text/plain"
        expiration_date = "2027-06-30T23:59:59Z"
      }
    }

    tags = {
      project     = "Platform"
      environment = "Dev"
      WBS         = "200"
    }
  }
}
