locals {
  tags = merge(var.tags, { managed_by = "terraform" })
}

resource "azurerm_windows_virtual_machine" "this" {
  name                     = var.name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  size                     = var.vm_size
  admin_username           = var.admin_username
  admin_password           = var.admin_password
  network_interface_ids    = var.network_interface_ids
  availability_set_id      = var.availability_set_id
  zone                     = var.zone
  custom_data              = var.custom_data
  timezone                 = var.timezone
  provision_vm_agent       = var.provision_vm_agent
  enable_automatic_updates = var.enable_automatic_updates
  patch_mode               = var.patch_mode
  tags                     = local.tags

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

  dynamic "winrm_listener" {
    for_each = var.winrm_listeners
    content {
      protocol        = winrm_listener.value.protocol
      certificate_url = winrm_listener.value.certificate_url
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_uri != null ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics_storage_uri
    }
  }
}