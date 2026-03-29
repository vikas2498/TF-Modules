locals {
  tags = merge(var.tags, { managed_by = "terraform" })
}

resource "azurerm_resource_group" "this" {
  name       = var.name
  location   = var.location
  managed_by = var.managed_by
  tags       = local.tags
}
