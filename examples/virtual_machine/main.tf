locals {
 # ── Deduplicate Resource Groups across Linux + Windows VMs ────────────
  resource_groups_map = {
    for rg_key, rg_value in merge(
      { for k, v in var.linux_virtual_machines : v.resource_group_name => {
          name         = v.resource_group_name
          location     = v.location
          use_existing = v.use_existing_rg
          tags         = v.tags
        }
      },
      { for k, v in var.windows_virtual_machines : v.resource_group_name => {
          name         = v.resource_group_name
          location     = v.location
          use_existing = v.use_existing_rg
          tags         = v.tags
        }
      }
    ) : rg_key => rg_value
  }

  # ── Flatten IP Configurations for Linux VMs ───────────────────────────
  linux_ip_configurations = merge([
    for vm_key, vm_value in var.linux_virtual_machines : {
      for ip_key, ip_value in vm_value.ip_configurations :
      "linux-${vm_key}-${ip_key}" => {
        vm_key                   = vm_key
        ip_key                   = ip_key
        vnet_name                = ip_value.vnet_name
        vnet_resource_group_name = ip_value.vnet_resource_group_name
        subnet_name              = ip_value.subnet_name
      }
    }
  ]...)

  # ── Flatten IP Configurations for Windows VMs ─────────────────────────
  windows_ip_configurations = merge([
    for vm_key, vm_value in var.windows_virtual_machines : {
      for ip_key, ip_value in vm_value.ip_configurations :
      "windows-${vm_key}-${ip_key}" => {
        vm_key                   = vm_key
        ip_key                   = ip_key
        vnet_name                = ip_value.vnet_name
        vnet_resource_group_name = ip_value.vnet_resource_group_name
        subnet_name              = ip_value.subnet_name
      }
    }
  ]...)

  # ── Flatten Data Disks for Linux VMs ──────────────────────────────────
  linux_data_disks = merge([
    for vm_key, vm_value in var.linux_virtual_machines : {
      for disk_key, disk_value in vm_value.data_disks :
      "${vm_key}-${disk_key}" => {
        vm_key               = vm_key
        disk_key             = disk_key
        location             = vm_value.location
        resource_group_name  = vm_value.resource_group_name
        zone                 = vm_value.zone
        disk_size_gb         = disk_value.disk_size_gb
        storage_account_type = disk_value.storage_account_type
        lun                  = disk_value.lun
        caching              = disk_value.caching
        create_option        = disk_value.create_option
        tags                 = vm_value.tags
      }
    }
  ]...)

  # ── Flatten Data Disks for Windows VMs ────────────────────────────────
  windows_data_disks = merge([
    for vm_key, vm_value in var.windows_virtual_machines : {
      for disk_key, disk_value in vm_value.data_disks :
      "${vm_key}-${disk_key}" => {
        vm_key               = vm_key
        disk_key             = disk_key
        location             = vm_value.location
        resource_group_name  = vm_value.resource_group_name
        zone                 = vm_value.zone
        disk_size_gb         = disk_value.disk_size_gb
        storage_account_type = disk_value.storage_account_type
        lun                  = disk_value.lun
        caching              = disk_value.caching
        create_option        = disk_value.create_option
        tags                 = vm_value.tags
      }
    }
  ]...)
}

# ── Step 1: Create or reference existing Resource Groups ──────────────
module "resource_group" {
  source   = "../../modules/resource_group"
  for_each = local.resource_groups_map

  name         = each.value.name
  location     = each.value.location
  use_existing = each.value.use_existing   # ← true = data source, false = create
  tags         = each.value.tags
}

# ── Data Source: Subnet lookup for Linux VMs ───────────────────────────
data "azurerm_subnet" "linux" {
  for_each = local.linux_ip_configurations

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_resource_group_name
}

# ── Data Source: Subnet lookup for Windows VMs ────────────────────────
data "azurerm_subnet" "windows" {
  for_each = local.windows_ip_configurations

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_resource_group_name
}

# ── Step 2a: Create NICs for Linux VMs ────────────────────────────────
module "linux_nic" {
  source     = "../../modules/network_interface"
  for_each   = var.linux_virtual_machines
  depends_on = [module.resource_group]

  name                          = "${each.key}-nic"
  location                      = each.value.location
  resource_group_name           = each.value.resource_group_name
  enable_accelerated_networking = each.value.enable_accelerated_networking
  enable_ip_forwarding          = each.value.enable_ip_forwarding
  dns_servers                   = each.value.dns_servers
  tags                          = each.value.tags

  ip_configurations = {
    for ip_key, ip_value in each.value.ip_configurations :
    ip_key => {
      subnet_id                     = data.azurerm_subnet.linux["linux-${each.key}-${ip_key}"].id
      private_ip_address_allocation = ip_value.private_ip_address_allocation
      private_ip_address            = ip_value.private_ip_address
      public_ip_address_id          = ip_value.public_ip_address_id
      primary                       = ip_value.primary
    }
  }
}

# ── Step 2b: Create NICs for Windows VMs ──────────────────────────────
module "windows_nic" {
  source     = "../../modules/network_interface"
  for_each   = var.windows_virtual_machines
  depends_on = [module.resource_group]

  name                          = "${each.key}-nic"
  location                      = each.value.location
  resource_group_name           = each.value.resource_group_name
  enable_accelerated_networking = each.value.enable_accelerated_networking
  enable_ip_forwarding          = each.value.enable_ip_forwarding
  dns_servers                   = each.value.dns_servers
  tags                          = each.value.tags

  ip_configurations = {
    for ip_key, ip_value in each.value.ip_configurations :
    ip_key => {
      subnet_id                     = data.azurerm_subnet.windows["windows-${each.key}-${ip_key}"].id
      private_ip_address_allocation = ip_value.private_ip_address_allocation
      private_ip_address            = ip_value.private_ip_address
      public_ip_address_id          = ip_value.public_ip_address_id
      primary                       = ip_value.primary
    }
  }
}

# ── Step 3a: Create Linux Virtual Machines ────────────────────────────
module "linux_virtual_machine" {
  source     = "../../modules/linux_virtual_machine"
  for_each   = var.linux_virtual_machines
  depends_on = [module.resource_group]

  name                            = each.key
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  vm_size                         = each.value.vm_size
  admin_username                  = each.value.admin_username
  admin_ssh_key                   = each.value.admin_ssh_key       # ← Optional SSH key
  admin_password                  = each.value.admin_password       # ← Optional password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids           = [module.linux_nic[each.key].id]
  availability_set_id             = each.value.availability_set_id
  zone                            = each.value.zone
  boot_diagnostics_storage_uri    = each.value.boot_diagnostics_storage_uri
  custom_data                     = each.value.custom_data
  os_disk                         = each.value.os_disk
  source_image                    = each.value.source_image
  tags                            = each.value.tags
}

# ── Step 3b: Create Windows Virtual Machines ──────────────────────────
module "windows_virtual_machine" {
  source     = "../../modules/windows_virtual_machine"
  for_each   = var.windows_virtual_machines
  depends_on = [module.resource_group]

  name                         = each.key
  location                     = each.value.location
  resource_group_name          = each.value.resource_group_name
  vm_size                      = each.value.vm_size
  admin_username               = each.value.admin_username
  admin_password               = each.value.admin_password
  network_interface_ids        = [module.windows_nic[each.key].id]
  timezone                     = each.value.timezone
  provision_vm_agent           = each.value.provision_vm_agent
  enable_automatic_updates     = each.value.enable_automatic_updates
  patch_mode                   = each.value.patch_mode
  winrm_listeners              = each.value.winrm_listeners
  availability_set_id          = each.value.availability_set_id
  zone                         = each.value.zone
  boot_diagnostics_storage_uri = each.value.boot_diagnostics_storage_uri
  custom_data                  = each.value.custom_data
  os_disk                      = each.value.os_disk
  source_image                 = each.value.source_image
  tags                         = each.value.tags
}

# ── Step 4a: Create Managed Data Disks for Linux VMs ──────────────────
module "linux_managed_disk" {
  source     = "../../modules/managed_disk"
  for_each   = local.linux_data_disks
  depends_on = [module.resource_group]

  name                 = "${each.value.vm_key}-${each.value.disk_key}"
  location             = each.value.location
  resource_group_name  = each.value.resource_group_name
  storage_account_type = each.value.storage_account_type
  disk_size_gb         = each.value.disk_size_gb
  create_option        = each.value.create_option
  zone                 = each.value.zone
  tags                 = each.value.tags
}

# ── Step 4b: Create Managed Data Disks for Windows VMs ────────────────
module "windows_managed_disk" {
  source     = "../../modules/managed_disk"
  for_each   = local.windows_data_disks
  depends_on = [module.resource_group]

  name                 = "${each.value.vm_key}-${each.value.disk_key}"
  location             = each.value.location
  resource_group_name  = each.value.resource_group_name
  storage_account_type = each.value.storage_account_type
  disk_size_gb         = each.value.disk_size_gb
  create_option        = each.value.create_option
  zone                 = each.value.zone
  tags                 = each.value.tags
}

# ── Step 5a: Attach Data Disks to Linux VMs ───────────────────────────
resource "azurerm_virtual_machine_data_disk_attachment" "linux" {
  for_each = local.linux_data_disks

  managed_disk_id    = module.linux_managed_disk[each.key].id
  virtual_machine_id = module.linux_virtual_machine[each.value.vm_key].vm_id
  lun                = each.value.lun
  caching            = each.value.caching
}

# ── Step 5b: Attach Data Disks to Windows VMs ─────────────────────────
resource "azurerm_virtual_machine_data_disk_attachment" "windows" {
  for_each = local.windows_data_disks

  managed_disk_id    = module.windows_managed_disk[each.key].id
  virtual_machine_id = module.windows_virtual_machine[each.value.vm_key].vm_id
  lun                = each.value.lun
  caching            = each.value.caching
}