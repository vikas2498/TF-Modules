locals {
  tags = merge(var.tags, { managed_by = "terraform" })
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.sku_name
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  tags                            = local.tags

  # ── Access Policies ──────────────────────────────────────────────────
  dynamic "access_policy" {
    for_each = var.access_policies
    content {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = access_policy.value.object_id
      application_id          = access_policy.value.application_id
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      certificate_permissions = access_policy.value.certificate_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }

  # ── Network ACLs ─────────────────────────────────────────────────────
  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []
    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }
}

# ── Private Endpoint ─────────────────────────────────────────────────────

locals {
  create_private_endpoint = var.private_endpoint != null
}

data "azurerm_subnet" "pe" {
  count = local.create_private_endpoint ? 1 : 0

  name                 = var.private_endpoint.subnet_name
  virtual_network_name = var.private_endpoint.virtual_network_name
  resource_group_name  = var.private_endpoint.subnet_resource_group_name != null ? var.private_endpoint.subnet_resource_group_name : var.resource_group_name
}

data "azurerm_private_dns_zone" "pe" {
  count = local.create_private_endpoint && var.private_endpoint.private_dns_zone_name != null ? 1 : 0

  name                = var.private_endpoint.private_dns_zone_name
  resource_group_name = var.private_endpoint.dns_zone_resource_group_name != null ? var.private_endpoint.dns_zone_resource_group_name : var.resource_group_name
}

resource "azurerm_private_endpoint" "this" {
  count = local.create_private_endpoint ? 1 : 0

  name                = var.private_endpoint.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.pe[0].id
  tags                = local.tags

  private_service_connection {
    name                           = "${var.private_endpoint.name}-psc"
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_endpoint.private_dns_zone_name != null ? [1] : []
    content {
      name                 = "${var.private_endpoint.name}-dns-zone-group"
      private_dns_zone_ids = [data.azurerm_private_dns_zone.pe[0].id]
    }
  }
}
