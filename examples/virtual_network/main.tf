/*
 * Virtual Network Module
 * 
 * This module creates one or more Azure Virtual Networks with their associated configurations.
 * It uses a for_each loop to manage multiple virtual networks based on the provided variable.
 * 
 * Module Configuration:
 * - source: References the virtual_network module located in the modules directory
 * - for_each: Iterates over var.virtual_networks to create multiple instances
 * 
 * Input Variables:
 * - name: The name of the virtual network (derived from each.key)
 * - location: Azure region where the virtual network will be deployed
 * - resource_group_name: The name of the resource group to deploy into
 * - address_space: The address space(s) for the virtual network (CIDR notation)
 * - subnets: Configuration for subnets within the virtual network
 * - tags: Azure tags for resource organization and cost tracking
 * 
 * Usage:
 * Define var.virtual_networks as a map of objects containing the above properties.
 * Example:
 *   virtual_networks = {
 *     "vnet-prod" = {
 *       location            = "eastus"
 *       resource_group_name = "rg-prod"
 *       address_space       = ["10.0.0.0/16"]
 *       subnets             = [...]
 *       tags                = {...}
 *     }
 *   }
 */
 
module "virtual_network" {
  source   = "../../modules/virtual_network"
  for_each = var.virtual_networks

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  subnets             = each.value.subnets
  tags                = each.value.tags
}