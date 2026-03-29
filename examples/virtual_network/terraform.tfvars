# Terraform Virtual Networks Configuration

## Overview
This `terraform.tfvars` file defines the configuration for Azure Virtual Networks (VNets) and their associated subnets, network security groups, and route tables.

## Structure

### virtual_networks
A map of virtual network configurations, where each key is a unique VNet name.

#### Required Parameters (per VNet)
- **name**: The key name of the virtual network (e.g., "EA-WE-prd-Vnet")
- **location**: Azure region where the VNet will be deployed
- **resource_group_name**: Name of the Azure resource group to host the VNet
- **address_space**: List of CIDR blocks assigned to the VNet

#### Optional Parameters (per VNet)
- **subnets**: Map of subnet configurations within the VNet
    - **address_prefixes**: CIDR block(s) for the subnet
    - **service_endpoints**: Azure services accessible via private endpoints (e.g., Storage, KeyVault)
    - **network_security_group**: NSG rules for subnet traffic control
        - **rules**: Array of security rules with properties like name, priority, direction, access, protocol, port ranges, and address prefixes
    - **private_endpoint_network_policies_enabled**: Boolean to enable/disable network policies for private endpoints
    - **default_outbound_access_enabled**: Boolean to control default outbound access
    - **route_table**: Optional User Defined Routes (UDR) with custom routing rules
- **tags**: Metadata labels for resource organization and billing (e.g., environment, project, Resource type)

## Examples Included
1. **EA-WE-prd-Vnet**: Production virtual network with 4 subnets (web, app, database, DMZ) including HTTP/HTTPS ingress rules
2. **EA-WE-nprd-Vnet**: Non-production virtual network with 3 subnets (web, app, database)

## Notes
- Commented-out sections demonstrate optional features such as route tables with custom next-hop configurations
- Service endpoints restrict network access to specified Azure services
- NSG rules use priority values for rule evaluation order (lower numbers evaluated first)
# ── Virtual Network Configuration ─────────────────────────────────────
# Only name, location, resource_group_name and address_space are required.
# Add or remove entries to control how many VNets are deployed.

virtual_networks = {
  "EA-WE-prd-Vnet" = {
    location            = "West Europe"
    resource_group_name = "EA-WE-D-RG-Net"
    address_space       = ["10.75.0.0/16"]

    subnets = {
      "EA-WE-prd-web-snet" = {
        address_prefixes  = ["10.75.12.0/24"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
        # OPTIONAL: Define an NSG to be created and associated with this subnet
        network_security_group = {
          rules = [
            { 
               name = "Allow_HTTP_Inbound",
               priority = 100,
               direction = "Inbound",
               access = "Allow",
               protocol = "Tcp",
               source_port_range = "*",
               destination_port_range = "80",
               source_address_prefix = "Internet",
               destination_address_prefix = "*"
             },
            {
                 name = "Allow_HTTPS_Inbound", 
                 priority = 110, 
                 direction = "Inbound", 
                 access = "Allow", 
                 protocol = "Tcp", 
                 source_port_range = "*", 
                 destination_port_range = "443", 
                 source_address_prefix = "Internet", 
                 destination_address_prefix = "*" }
          ]
        }
      }
      "EA-WE-prd-app-snet" = {
        address_prefixes = ["10.75.13.0/24"]
      }
      "EA-WE-prd-db-snet" = {
        address_prefixes                          = ["10.75.14.0/24"]
        private_endpoint_network_policies_enabled = false
      }
      "EA-WE-prd-dmz-snet" = {
        address_prefixes                = ["10.75.15.0/24"]
        default_outbound_access_enabled = false
        # OPTIONAL: Define a Route Table (UDR) to be created and associated
       // route_table = {
       //   routes = [
       //     { name = "ToFirewall",
       //       address_prefix = "0.0.0.0/0",
       //       next_hop_type = "VirtualAppliance",
       //       next_hop_in_ip_address = "10.75.100.4" 
       //       }
       //   ]
       // }
      }
    }
    tags = {
      environment = "Prod"
      project     = "platform"
      Resource    = "Virtual Network"
    }
  }
  # ... other virtual networks ...

  "EA-WE-nprd-Vnet" = {
    location            = "West Europe"
    resource_group_name = "EA-WE-D-RG-Net"
    address_space       = ["10.74.0.0/16"]

    subnets = {
      "EA-WE-d-web-snet" = {
        address_prefixes  = ["10.74.12.0/24"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
      "EA-WE-d-app-snet"= {
        address_prefixes = ["10.74.17.0/24"]
      }
      "EA-WE-d-db-snet" = {
        address_prefixes                          = ["10.74.18.0/24"]
        private_endpoint_network_policies_enabled = false
      }
    }

    tags = {
      environment = "dev"
      project     = "platform"
      Resource    = "Virtual Network"
    }
  }
}