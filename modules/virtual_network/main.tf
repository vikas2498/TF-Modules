# Virtual Network Module Documentation

## Overview
# This Terraform module creates an Azure Virtual Network with comprehensive networking components including subnets, Network Security Groups (NSGs), and Route Tables. It provides a complete infrastructure-as-code solution for Azure network provisioning.

## Resources Created

### Primary Resources
# azurerm_virtual_network**: Creates the main virtual network with configurable address spaces and DNS settings
# azurerm_subnet**: Creates subnets within the virtual network with customizable network policies
# azurerm_network_security_group**: Creates NSGs for subnets that require security rule definitions
# azurerm_route_table**: Creates route tables for subnets that require custom routing configuration

### Association Resources
# azurerm_subnet_network_security_group_association**: Associates NSGs with their respective subnets
# azurerm_subnet_route_table_association**: Associates route tables with their respective subnets

## Key Features

### Dynamic Resource Creation
# NSGs and Route Tables are created only for subnets that explicitly define them
# Uses `for_each` loops for efficient, scalable resource management
# Supports dynamic security rule and route definitions within NSGs and Route Tables

### Naming Convention
# NSG names are automatically derived from subnet names by replacing "-snet" with "-nsg"
# Route Table names are automatically derived from subnet names by replacing "-snet" with "-RT"

### Tagging and Management
# Automatically applies consistent tags across all resources
# Includes managed-by terraform tag for resource tracking
# Merges user-provided tags with system tags

### Subnet Configuration Options
# Service endpoint configuration
# Private endpoint network policies control
# Private link service network policies control
# Outbound access settings per subnet



locals {
  tags = merge(var.tags, { managed_by = "terraform" })
}

resource "azurerm_virtual_network" "this" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  address_space           = var.address_space
  dns_servers             = var.dns_servers
  bgp_community           = var.bgp_community
  edge_zone               = var.edge_zone
  flow_timeout_in_minutes = var.flow_timeout_in_minutes
  tags                    = local.tags
}

# Create NSG for each subnet that defines one
resource "azurerm_network_security_group" "this" {
  for_each = { for k, v in var.subnets : k => v if v.network_security_group != null }

  # Replace "-snet" from the subnet key with "-nsg" to form the name
  name                = "${replace(each.key, "-snet", "-nsg")}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  dynamic "security_rule" {
    for_each = each.value.network_security_group.rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# Create Route Table for each subnet that defines one
resource "azurerm_route_table" "this" {
  for_each = { for k, v in var.subnets : k => v if v.route_table != null }

  # Replace "-snet" from the subnet key with "-RT" to form the name
  name                = "${replace(each.key, "-snet", "-RT")}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  dynamic "route" {
    for_each = each.value.route_table.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
}



resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes

  service_endpoints = length(each.value.service_endpoints) > 0 ? each.value.service_endpoints : null

  default_outbound_access_enabled = each.value.default_outbound_access_enabled

  private_endpoint_network_policies_enabled = each.value.private_endpoint_network_policies_enabled

  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
}

# Associate the NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = { for k, v in var.subnets : k => v if v.network_security_group != null }

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}

# Associate the Route Table with the subnet
resource "azurerm_subnet_route_table_association" "this" {
  for_each = { for k, v in var.subnets : k => v if v.route_table != null }

  subnet_id      = azurerm_subnet.this[each.key].id
  route_table_id = azurerm_route_table.this[each.key].id
}