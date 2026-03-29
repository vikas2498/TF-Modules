/*
# Linux Virtual Machine Module - Main Configuration

## Overview
This Terraform configuration defines a complete Linux virtual machine resource for Azure infrastructure with comprehensive validation and flexible authentication options.

## Local Values

### tags
Merges user-provided tags with a managed-by identifier to track resources created by Terraform.

## Validation

### auth_validation
Enforces authentication configuration preconditions:
- **SSH Key Authentication**: When `disable_password_authentication = true`, an SSH public key must be provided via `admin_ssh_key`
- **Password Authentication**: When `disable_password_authentication = false`, a password must be provided via `admin_password`

Fails with a descriptive error if configuration does not match one of these two valid states.

## Resources

### azurerm_linux_virtual_machine (this)
Manages the Azure Linux virtual machine instance with the following capabilities:

**Core Configuration**:
- VM name, location, resource group, and size
- Admin username with flexible authentication (SSH key or password)
- Network interface attachment and optional availability set/zone placement
- Custom data for VM initialization

**Storage**:
- OS disk configuration with name, caching strategy, storage type, and optional size customization
- Boot diagnostics support with optional storage account URI

**Image**:
- Flexible source image specification via publisher, offer, SKU, and version

**Authentication**:
- Conditional SSH key block only provisioned when SSH authentication is enabled
- Password field set to null when SSH authentication is active

**Lifecycle Management**:
- Ignores identity changes to prevent unnecessary updates
- Prevents accidental VM deletion (can be modified as needed)

## Variables Required
- `name`, `location`, `resource_group_name`: VM identification and placement
- `vm_size`: Azure VM size SKU
- `admin_username`: Administrative user account
- `admin_password`, `admin_ssh_key`: Authentication credentials (one required based on auth method)
- `disable_password_authentication`: Boolean flag to select auth method
- `network_interface_ids`: Network attachment specification
- `os_disk`, `source_image`: Complex configuration objects
- Optional: `availability_set_id`, `zone`, `custom_data`, `boot_diagnostics_storage_uri`, `tags`
*/
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
  lifecycle {
    # Prevent Terraform from trying to power off/on a deallocated VM
    ignore_changes = [
      identity,
    ]
    # Prevent accidental deletion of VM
    prevent_destroy = false
  }
}