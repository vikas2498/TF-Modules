locals {
  tags = merge(var.tags, { managed_by = "terraform" })
}

resource "azurerm_linux_virtual_machine" "this" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids           = var.network_interface_ids
  availability_set_id             = var.availability_set_id
  zone                            = var.zone
  custom_data                     = var.custom_data
  tags                            = local.tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  os_disk {
    name                 = "${var.name}-osdisk"
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.source_image.publisher
    offer     = var.source_image.offer
    sku       = var.source_image.sku
    version   = var.source_image.version
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_uri != null ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics_storage_uri
    }
  }
}