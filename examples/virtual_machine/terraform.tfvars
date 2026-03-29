# ── Linux Virtual Machines ─────────────────────────────────────────────
linux_virtual_machines = {
  "EAWElappd03" = {
    location            = "West Europe"
    resource_group_name = "EA-WE-D-RG-D03"
    use_existing_rg     = true
    vm_size             = "Standard_D2s_v3"
    admin_username      = "azureuser"

  # SSH Key Authentication
  # disable_password_authentication = true
  # admin_ssh_key       = "ssh-rsa AAAA........"

    # Password Authentication
    disable_password_authentication = false
    admin_password                  = "P@ssw0rd1234!"

    ip_configurations = {
      "ipconfig01" = {
        vnet_name                     = "EA-WE-nprd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-d-app-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.74.17.12"
        primary                       = true
      }
     "ipconfig02" = {
        vnet_name                     = "EA-WE-nprd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-d-app-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.74.17.13"
        primary                       = false
      }
      "ipconfig03" = {
        vnet_name                     = "EA-WE-nprd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-d-app-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.74.17.14"
        primary                       = false
      }
    }
    enable_accelerated_networking = true

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 128
    }

    source_image = {
      publisher = "suse"
      offer     = "sles-15-sp5"
      sku       = "gen1"
      version   = "latest"
    }

    zone = "1"

    data_disks = {
      "datadisk1" = {
        disk_size_gb         = 256
        storage_account_type = "Premium_LRS"
        lun                  = 0
        caching              = "ReadWrite"
      }
    }

    tags = {
      environment = "Prod"
      os_type     = "Linux"
      project     = "platform"
      Resource    = "Virtual Machine"
    }
  }
}

# ── Windows Virtual Machines ───────────────────────────────────────────
windows_virtual_machines = {
  "EAWEWAPPD03" = {
    location            = "West Europe"
    resource_group_name = "EA-WE-D-RG-D03"
    use_existing_rg     = true
    vm_size             = "Standard_D4s_v3"
    admin_username      = "azureuser"
    admin_password      = "P@ssw0rd1234!"

    timezone                 = "GMT Standard Time"
    enable_automatic_updates = true
    patch_mode               = "AutomaticByOS"

    ip_configurations = {
       "ipconfig01" = {
        vnet_name                     = "EA-WE-nprd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-d-app-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.74.17.16"
        primary                       = true
      },
      "ipconfig02" = {
        vnet_name                     = "EA-WE-nprd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-d-app-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.74.17.17"
        primary                       = false
      }
    }
    enable_accelerated_networking = true

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 256
    }

    source_image = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-Datacenter"
      version   = "latest"
    }

    zone = "1"

    data_disks = {
      "datadisk01" = {
        disk_size_gb         = 512
        storage_account_type = "Premium_LRS"
        lun                  = 0
        caching              = "ReadWrite"
      },
       "datadisk02" = {
        disk_size_gb         = 512
        storage_account_type = "Premium_LRS"
        lun                  = 0
        caching              = "ReadWrite"
      }
    }

    tags = {
      environment = "Prod"
      os_type     = "Windows"
      project     = "platform"
      Resource    = "Virtual Machine"
    }
  },
  "EAWEWAPPD07" = {
    location            = "West Europe"
    resource_group_name = "EA-WE-D-RG-D07"
    vm_size             = "Standard_D4s_v3"
    admin_username      = "azureuser"
    admin_password      = "P@ssw0rd1234!"

    timezone                 = "GMT Standard Time"
    enable_automatic_updates = true
    patch_mode               = "AutomaticByOS"

    ip_configurations = {
       "ipconfig01" = {
        vnet_name                     = "EA-WE-nprd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-d-app-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.74.17.19"
        primary                       = true
      },
      "ipconfig02" = {
        vnet_name                     = "EA-WE-nprd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-d-app-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.74.17.20"
        primary                       = false
      }
    }
    enable_accelerated_networking = true

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 256
    }

    source_image = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-Datacenter"
      version   = "latest"
    }

    zone = "1"

    data_disks = {
      "datadisk01" = {
        disk_size_gb         = 512
        storage_account_type = "Premium_LRS"
        lun                  = 0
        caching              = "ReadWrite"
      },
       "datadisk02" = {
        disk_size_gb         = 512
        storage_account_type = "Premium_LRS"
        lun                  = 0
        caching              = "ReadWrite"
      }
    }

    tags = {
      environment = "Prod"
      os_type     = "Windows"
      project     = "platform"
      Resource    = "Virtual Machine"
    }
  }
}