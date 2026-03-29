locals {
  tags = merge(var.tags, { managed_by = "terraform" })
}

resource "azurerm_network_interface" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  dns_servers                   = length(var.dns_servers) > 0 ? var.dns_servers : null
  enable_accelerated_networking = var.enable_accelerated_networking
  enable_ip_forwarding          = var.enable_ip_forwarding
  internal_dns_name_label       = var.internal_dns_name_label
  tags                          = local.tags

  dynamic "ip_configuration" {
    for_each = var.ip_configurations
    content {
      name                          = ip_configuration.key
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address            = ip_configuration.value.private_ip_address_allocation == "Static" ? ip_configuration.value.private_ip_address : null
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      primary                       = ip_configuration.value.primary
    }
  }
}