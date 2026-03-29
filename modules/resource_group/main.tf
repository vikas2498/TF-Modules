locals {
  tags = merge(var.tags, { managed_by = "terraform" })
}

# ── Try to read existing Resource Group ───────────────────────────────
data "azurerm_resource_group" "existing" {
  count = var.use_existing ? 1 : 0
  name  = var.name
}

# ── Create Resource Group only if use_existing = false ────────────────
resource "azurerm_resource_group" "this" {
  count    = var.use_existing ? 0 : 1
  name     = var.name
  location = var.location
  tags     = local.tags
}