# ── Linux Virtual Machines ─────────────────────────────────────────────
variable "linux_virtual_machines" {
  description = "A map of Linux virtual machines to create."
  type = map(object({
    location            = string
    resource_group_name = string
    vm_size             = string
    admin_username      = string
    admin_ssh_key       = string

    # NIC Configuration
    ip_configurations = map(object({
      vnet_name                     = string
      vnet_resource_group_name      = string
      subnet_name                   = string
      private_ip_address_allocation = optional(string, "Dynamic")
      private_ip_address            = optional(string)
      public_ip_address_id          = optional(string)
      primary                       = optional(bool, false)
    }))
    dns_servers                     = optional(list(string), [])
    enable_accelerated_networking   = optional(bool, false)
    enable_ip_forwarding            = optional(bool, false)
    disable_password_authentication = optional(bool, true)
    availability_set_id             = optional(string)
    zone                            = optional(string)
    boot_diagnostics_storage_uri    = optional(string)
    custom_data                     = optional(string)

    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "Premium_LRS")
      disk_size_gb         = optional(number, 128)
    }), {})

    source_image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = optional(string, "latest")
    })

    data_disks = optional(map(object({
      disk_size_gb         = number
      storage_account_type = optional(string, "Premium_LRS")
      lun                  = number
      caching              = optional(string, "ReadWrite")
      create_option        = optional(string, "Empty")
    })), {})

    tags = optional(map(string), {})
  }))
  default = {}
}

# ── Windows Virtual Machines ───────────────────────────────────────────
variable "windows_virtual_machines" {
  description = "A map of Windows virtual machines to create."
  type = map(object({
    location            = string
    resource_group_name = string
    vm_size             = string
    admin_username      = string
    admin_password      = string

    # Windows Specific
    timezone                 = optional(string, "UTC")
    provision_vm_agent       = optional(bool, true)
    enable_automatic_updates = optional(bool, true)
    patch_mode               = optional(string, "AutomaticByOS")
    winrm_listeners = optional(list(object({
      protocol        = string
      certificate_url = optional(string)
    })), [])

    # NIC Configuration
    ip_configurations = map(object({
      vnet_name                     = string
      vnet_resource_group_name      = string
      subnet_name                   = string
      private_ip_address_allocation = optional(string, "Dynamic")
      private_ip_address            = optional(string)
      public_ip_address_id          = optional(string)
      primary                       = optional(bool, false)
    }))
    dns_servers                  = optional(list(string), [])
    enable_accelerated_networking = optional(bool, false)
    enable_ip_forwarding         = optional(bool, false)
    availability_set_id          = optional(string)
    zone                         = optional(string)
    boot_diagnostics_storage_uri = optional(string)
    custom_data                  = optional(string)

    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "Premium_LRS")
      disk_size_gb         = optional(number, 128)
    }), {})

    source_image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = optional(string, "latest")
    })

    data_disks = optional(map(object({
      disk_size_gb         = number
      storage_account_type = optional(string, "Premium_LRS")
      lun                  = number
      caching              = optional(string, "ReadWrite")
      create_option        = optional(string, "Empty")
    })), {})

    tags = optional(map(string), {})
  }))
  default = {}
}