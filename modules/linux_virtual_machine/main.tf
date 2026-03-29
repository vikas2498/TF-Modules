locals {
  tags = merge(var.tags, { managed_by = "terraform" })
}

# ── Validation: Ensure correct auth method is provided ────────────────
resource "terraform_data" "auth_validation" {
  lifecycle {
    precondition {
      condition = (
        # SSH key auth: disable_password_authentication = true and ssh key must be provided
        (var.disable_password_authentication == true && var.admin_ssh_key != null) ||
        # Password auth: disable_password_authentication = false and password must be provided
        (var.disable_password_authentication == false && var.admin_password != null)
      )
      error_message = "Authentication misconfiguration: When disable_password_authentication = true, admin_ssh_key must be provided. When disable_password_authentication = false, admin_password must be provided."
    }
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.disable_password_authentication == false ? var.admin_password : null
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids           = var.network_interface_ids
  availability_set_id             = var.availability_set_id
  zone                            = var.zone
  custom_data                     = var.custom_data
  tags                            = local.tags

  # SSH key block - only added when disable_password_authentication = true
  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication == true && var.admin_ssh_key != null ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.admin_ssh_key
    }
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