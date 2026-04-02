module "key_vaults" {
  source   = "../../modules/key_vault"
  for_each = var.key_vaults

  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  sku_name                        = each.value.sku_name
  enabled_for_deployment          = each.value.enabled_for_deployment
  enabled_for_disk_encryption     = each.value.enabled_for_disk_encryption
  enabled_for_template_deployment = each.value.enabled_for_template_deployment
  enable_rbac_authorization       = each.value.enable_rbac_authorization
  soft_delete_retention_days      = each.value.soft_delete_retention_days
  purge_protection_enabled        = each.value.purge_protection_enabled
  public_network_access_enabled   = each.value.public_network_access_enabled
  tags                            = each.value.tags
  access_policies                 = each.value.access_policies
  network_acls                    = each.value.network_acls
  private_endpoint                = each.value.private_endpoint
}
