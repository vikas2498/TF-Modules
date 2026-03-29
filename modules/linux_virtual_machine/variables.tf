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

variable "admin_ssh_key" {
  description = "Public SSH key for the administrator account."
  type        = string
}

variable "network_interface_ids" {
  description = "List of network interface IDs to attach to the virtual machine."
  type        = list(string)
}

variable "disable_password_authentication" {
  description = "(Optional) Disable password authentication on the VM."
  type        = bool
  default     = true
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