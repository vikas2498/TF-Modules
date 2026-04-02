locals {
  tags = merge(var.tags, { managed_by = "terraform" })
}

# ── Look up Key Vault by name ──────────────────────────────────────────

data "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

# ── Key Vault Secrets ──────────────────────────────────────────────────

resource "azurerm_key_vault_secret" "this" {
  for_each = var.secrets

  name            = each.value.name
  value           = each.value.value
  key_vault_id    = data.azurerm_key_vault.this.id
  content_type    = each.value.content_type
  not_before_date = each.value.not_before_date
  expiration_date = each.value.expiration_date
  tags            = merge(local.tags, each.value.tags)
}
