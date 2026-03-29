# ── Linux Virtual Machines ─────────────────────────────────────────────
linux_virtual_machines = {
  "EA-WE-prd-web-vm" = {
    location            = "West Europe"
    resource_group_name = "EA-WE-prd-RG-VM"
    vm_size             = "Standard_D2s_v3"
    admin_username      = "azureuser"
    admin_ssh_key       = "ssh-rsa AAAA........"

    ip_configurations = {
      "ipconfig1" = {
        vnet_name                     = "EA-WE-prd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-prd-web-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.75.12.10"
        primary                       = true
      }
      "ipconfig2" = {
        vnet_name                     = "EA-WE-prd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-prd-web-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.75.12.11"
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
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
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
  "EA-WE-prd-app-vm" = {
    location            = "West Europe"
    resource_group_name = "EA-WE-prd-RG-VM"
    vm_size             = "Standard_D4s_v3"
    admin_username      = "azureuser"
    admin_password      = "P@ssw0rd1234!"

    timezone                 = "GMT Standard Time"
    enable_automatic_updates = true
    patch_mode               = "AutomaticByOS"

    ip_configurations = {
      "ipconfig1" = {
        vnet_name                     = "EA-WE-prd-Vnet"
        vnet_resource_group_name      = "EA-WE-D-RG-Net"
        subnet_name                   = "EA-WE-prd-app-snet"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.75.13.10"
        primary                       = true
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
      "datadisk1" = {
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