/*
# Virtual Machine Variables Module

## Overview
Defines input variables for creating and configuring Linux and Windows virtual machines in Azure using Terraform.

## Variables

### linux_virtual_machines
A map of Linux virtual machine configurations to be provisioned.

**Type:** `map(object({...}))`

**Default:** `{}`

**Schema:**
- `location` (string, required): Azure region for VM deployment
- `resource_group_name` (string, required): Name of the resource group
- `use_existing_rg` (bool, optional): Set to `true` if resource group already exists. Default: `false`
- `vm_size` (string, required): VM instance size (e.g., "Standard_B2s")
- `admin_username` (string, required): Linux admin user account name
- `admin_ssh_key` (string, optional): SSH public key for authentication
- `admin_password` (string, optional): Admin password (alternative to SSH key)
- `disable_password_authentication` (bool, optional): Disable password login. Default: `true`
- `ip_configurations` (map, required): Network interface configuration(s)
- `dns_servers` (list, optional): Custom DNS servers. Default: `[]`
- `enable_accelerated_networking` (bool, optional): Enable SR-IOV support. Default: `false`
- `enable_ip_forwarding` (bool, optional): Enable IP forwarding. Default: `false`
- `availability_set_id` (string, optional): Availability set resource ID
- `zone` (string, optional): Availability zone
- `boot_diagnostics_storage_uri` (string, optional): Storage account URI for diagnostics
- `custom_data` (string, optional): Cloud-init script data
- `os_disk` (object, optional): OS disk configuration with caching, storage type, and size
- `source_image` (object, required): Image details (publisher, offer, sku, version)
- `data_disks` (map, optional): Additional data disks configuration
- `tags` (map, optional): Azure resource tags. Default: `{}`

### windows_virtual_machines
A map of Windows virtual machine configurations to be provisioned.

**Type:** `map(object({...}))`

**Default:** `{}`

**Schema:** Same as Linux VMs with Windows-specific additions:
- `admin_password` (string, required): Windows admin password
- `timezone` (string, optional): Windows timezone. Default: `"UTC"`
- `provision_vm_agent` (bool, optional): Install Azure VM agent. Default: `true`
- `enable_automatic_updates` (bool, optional): Enable automatic Windows updates. Default: `true`
- `patch_mode` (string, optional): Update patch mode. Default: `"AutomaticByOS"`
- `winrm_listeners` (list, optional): WinRM listener configuration for remote management

## Notes
- SSH key is preferred for Linux authentication; password is fallback option
- Windows requires admin password; no SSH alternative
- IP configurations require referencing existing VNets and subnets
- Data disks are optional and can be added post-provisioning
- Tags are inherited from module variables and can be customized per VM
*/
# ── Linux Virtual Machines ─────────────────────────────────────────────
variable "linux_virtual_machines" {
  description = "A map of Linux virtual machines to create."
  type = map(object({
    location             = string
    resource_group_name  = string
    use_existing_rg      = optional(bool, false)   # ← true = RG already exists
    vm_size              = string
    admin_username       = string

    # Authentication
    admin_ssh_key                   = optional(string)
    admin_password                  = optional(string)
    disable_password_authentication = optional(bool, true)

    # NIC Configuration
    ip_configurations = map(object({
      vnet_name                     = string
      vnet_resource_group_name      = string
      subnet_name                   = string
      private_ip_address_allocation = optional(string, "Static")
      private_ip_address            = optional(string)
      public_ip_address_id          = optional(string)
      primary                       = optional(bool, false)
    }))
    dns_servers                   = optional(list(string), [])
    enable_accelerated_networking = optional(bool, false)
    enable_ip_forwarding          = optional(bool, false)
    availability_set_id           = optional(string)
    zone                          = optional(string)
    boot_diagnostics_storage_uri  = optional(string)
    custom_data                   = optional(string)

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
    location             = string
    resource_group_name  = string
    use_existing_rg      = optional(bool, false)   # ← true = RG already exists
    vm_size              = string
    admin_username       = string
    admin_password       = string

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
      private_ip_address_allocation = optional(string, "Static")
      private_ip_address            = optional(string)
      public_ip_address_id          = optional(string)
      primary                       = optional(bool, false)
    }))
    dns_servers                   = optional(list(string), [])
    enable_accelerated_networking = optional(bool, false)
    enable_ip_forwarding          = optional(bool, false)
    availability_set_id           = optional(string)
    zone                          = optional(string)
    boot_diagnostics_storage_uri  = optional(string)
    custom_data                   = optional(string)

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