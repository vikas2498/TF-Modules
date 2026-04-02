module "key_vault_secrets" {
  source   = "../../modules/key_vault_secret"
  for_each = var.key_vault_secrets

  key_vault_name      = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
  secrets             = each.value.secrets
  tags                = each.value.tags
}
