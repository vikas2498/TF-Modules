/*
# Linux Virtual Machine Terraform Module - Variables Documentation

## Overview
This module defines variables for creating and configuring Linux virtual machines in Azure. It supports both SSH key and password authentication, with flexible OS disk and source image configuration options.

## Required Variables

### name
- **Type:** string
- **Description:** Name of the Linux virtual machine.

### location
- **Type:** string
- **Description:** Azure region where the virtual machine will be created.

### resource_group_name
- **Type:** string
- **Description:** Name of the resource group in which to create the virtual machine.

### vm_size
- **Type:** string
- **Description:** Size of the virtual machine (e.g., Standard_D2s_v3).

### admin_username
- **Type:** string
- **Description:** Username for the local administrator account.

### network_interface_ids
- **Type:** list(string)
- **Description:** List of network interface IDs to attach to the virtual machine.

### source_image
- **Type:** object
- **Description:** Source image reference for the virtual machine.
- **Fields:**
  - `publisher` (string, required): Image publisher name
  - `offer` (string, required): Image offer name
  - `sku` (string, required): Image SKU
  - `version` (string, optional): Image version (defaults to "latest")

## Authentication Variables

### admin_ssh_key
- **Type:** string
- **Default:** null
- **Description:** Public SSH key for the administrator account. Required when `disable_password_authentication = true`.

### admin_password
- **Type:** string (sensitive)
- **Default:** null
- **Description:** Password for the administrator account. Required when `disable_password_authentication = false`.

### disable_password_authentication
- **Type:** bool
- **Default:** true
- **Description:** Controls authentication method. Set to `true` for SSH key authentication, `false` for password authentication.
- **Validation:** Must be either true or false.

## OS Disk Configuration

### os_disk
- **Type:** object
- **Default:** {}
- **Description:** OS disk configuration for the virtual machine.
- **Fields:**
  - `caching` (string, optional): Disk caching type (defaults to "ReadWrite")
  - `storage_account_type` (string, optional): Storage account type (defaults to "Premium_LRS")
  - `disk_size_gb` (number, optional): Disk size in GB (defaults to 128)

## Optional Variables

### availability_set_id
- **Type:** string
- **Default:** null
- **Description:** ID of the availability set for the VM.

### zone
- **Type:** string
- **Default:** null
- **Description:** Availability zone for the VM (e.g., 1, 2, 3).

### boot_diagnostics_storage_uri
- **Type:** string
- **Default:** null
- **Description:** Storage account URI for boot diagnostics.

### custom_data
- **Type:** string
- **Default:** null
- **Description:** Base64 encoded custom data to pass to the VM during initialization.

### tags
- **Type:** map(string)
- **Default:** {}
- **Description:** Tags to apply to all resources created by this module.
*/ 
# ── Required Variables ─────────────────────────────────────────────────
variable "name" {
  description = "Name of the Linux virtual machine."
  type        = string
}

variable "location" {
  description = "Azure region where the virtual machine will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine. e.g. Standard_D2s_v3"
  type        = string
}

variable "admin_username" {
  description = "Username for the local administrator account."
  type        = string
}

variable "network_interface_ids" {
  description = "List of network interface IDs to attach to the virtual machine."
  type        = list(string)
}

# ── Authentication Variables ───────────────────────────────────────────
variable "admin_ssh_key" {
  description = "(Optional) Public SSH key for the administrator account. Required when disable_password_authentication = true."
  type        = string
  default     = null
}

variable "admin_password" {
  description = "(Optional) Password for the administrator account. Required when disable_password_authentication = false."
  type        = string
  sensitive   = true
  default     = null
}

variable "disable_password_authentication" {
  description = "Disable password authentication. Set to false to use password auth, true to use SSH key auth."
  type        = bool
  default     = true

  validation {
    condition     = var.disable_password_authentication == true || var.disable_password_authentication == false
    error_message = "disable_password_authentication must be either true (SSH key) or false (password)."
  }
}

# ── OS Disk Variables ──────────────────────────────────────────────────
variable "os_disk" {
  description = "OS disk configuration for the virtual machine."
  type = object({
    caching              = optional(string, "ReadWrite")
    storage_account_type = optional(string, "Premium_LRS")
    disk_size_gb         = optional(number, 128)
  })
  default = {}
}

# ── Source Image Variables ─────────────────────────────────────────────
variable "source_image" {
  description = "Source image reference for the virtual machine."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = optional(string, "latest")
  })
}

# ── Optional Variables ─────────────────────────────────────────────────
variable "availability_set_id" {
  description = "(Optional) ID of the availability set."
  type        = string
  default     = null
}

variable "zone" {
  description = "(Optional) Availability zone for the VM. e.g. 1, 2, 3"
  type        = string
  default     = null
}

variable "boot_diagnostics_storage_uri" {
  description = "(Optional) Storage account URI for boot diagnostics."
  type        = string
  default     = null
}

variable "custom_data" {
  description = "(Optional) Base64 encoded custom data to pass to the VM."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) Tags to apply to all resources."
  type        = map(string)
  default     = {}
}