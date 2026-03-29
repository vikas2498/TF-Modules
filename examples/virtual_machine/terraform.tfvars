/*
# Terraform Virtual Machines Configuration

This file contains example configurations for deploying Linux and Windows virtual machines to Azure using Terraform.

## Linux Virtual Machines

Defines Linux VM instances with the following configurable properties:
- **Basic Settings**: Location, resource group, VM size, and authentication method
- **Authentication**: Supports both SSH key and password-based authentication
- **Networking**: Multiple IP configurations with static private IP allocation across subnets
- **Storage**: OS disk configuration with caching and storage account type specifications
- **Image**: SUSE Linux Enterprise Server (SLES) 15 SP5 source image
- **Availability**: Zone-based deployment for high availability
- **Data Disks**: Additional storage disks with configurable size and caching
- **Features**: Accelerated networking support
- **Metadata**: Resource tags for environment, OS type, project, and resource classification

## Windows Virtual Machines

Defines Windows Server VM instances with the following configurable properties:
- **Basic Settings**: Location, resource group, VM size, and credentials
- **OS Configuration**: Timezone, automatic updates, and patch management settings
- **Networking**: Multiple IP configurations with static private IP allocation
- **Storage**: Premium OS disk with specified caching and size
- **Image**: Windows Server 2022 Datacenter edition
- **Availability**: Zone-based deployment for high availability
- **Data Disks**: Multiple additional storage disks for application workloads
- **Features**: Accelerated networking support
- **Metadata**: Resource tags for environment, OS type, project, and resource classification

## Notes

- All VM configurations are currently commented out (example/template format)
- Both Linux and Windows VMs utilize Premium_LRS storage for production-grade performance
- Static IP allocation is configured for consistent network addressing
- Resource grouping and tagging follow organizational naming conventions
*/
# ── Linux Virtual Machines ─────────────────────────────────────────────
linux_virtual_machines = {
  /*
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
  */
}

# ── Windows Virtual Machines ───────────────────────────────────────────
windows_virtual_machines = {
  /*
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
        lun                  = 1
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
  */
}