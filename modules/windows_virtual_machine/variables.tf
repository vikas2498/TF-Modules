# ── Required Variables ─────────────────────────────────────────────────
variable "name" {
  description = "Name of the Windows virtual machine."
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

variable "admin_password" {
  description = "Password for the local administrator account."
  type        = string
  sensitive   = true
}

variable "network_interface_ids" {
  description = "List of network interface IDs to attach to the virtual machine."
  type        = list(string)
}

# ── Windows Specific Variables ─────────────────────────────────────────
variable "timezone" {
  description = "(Optional) Timezone for the VM. e.g. GMT Standard Time, UTC"
  type        = string
  default     = "UTC"
}

variable "provision_vm_agent" {
  description = "(Optional) Enable the Azure VM agent."
  type        = bool
  default     = true
}

variable "enable_automatic_updates" {
  description = "(Optional) Enable automatic Windows updates."
  type        = bool
  default     = true
}

variable "patch_mode" {
  description = "(Optional) Patching mode. e.g. AutomaticByOS, AutomaticByPlatform, Manual"
  type        = string
  default     = "AutomaticByOS"
}

variable "winrm_listeners" {
  description = "(Optional) WinRM listener configuration."
  type = list(object({
    protocol        = string
    certificate_url = optional(string)
  }))
  default = []
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