/**
 * @variable virtual_networks
 * @description A map of virtual networks to create. See terraform.tfvars for an example.
 * @type map(object)
 * 
 * @param {string} location - Azure region where the virtual network will be deployed
 * @param {string} resource_group_name - Name of the resource group containing the virtual network
 * @param {list(string)} address_space - List of CIDR blocks to assign to the virtual network
 * @param {map(string)} [tags={}] - Optional tags to apply to the virtual network
 * @param {map(object)} [subnets={}] - Optional map of subnets to create within the virtual network
 *   @param {list(string)} address_prefixes - List of CIDR blocks for the subnet
 *   @param {list(string)} [service_endpoints=[]] - Optional list of service endpoints to enable
 *   @param {bool} [private_endpoint_network_policies_enabled=true] - Enable/disable private endpoint network policies
 *   @param {bool} [private_link_service_network_policies_enabled=true] - Enable/disable private link service network policies
 *   @param {bool} [default_outbound_access_enabled=true] - Enable/disable default outbound access
 *   @param {object} [network_security_group] - Optional NSG configuration with security rules
 *     @param {list(object)} rules - List of security rules
 *       @param {string} name - Rule name
 *       @param {number} priority - Rule priority (100-4096)
 *       @param {string} direction - Direction (Inbound/Outbound)
 *       @param {string} access - Access level (Allow/Deny)
 *       @param {string} protocol - Protocol (TCP/UDP/*)
 *       @param {string} source_port_range - Source port range
 *       @param {string} destination_port_range - Destination port range
 *       @param {string} source_address_prefix - Source address prefix
 *       @param {string} destination_address_prefix - Destination address prefix
 *   @param {object} [route_table] - Optional route table configuration
 *     @param {list(object)} routes - List of custom routes
 *       @param {string} name - Route name
 *       @param {string} address_prefix - Destination CIDR block
 *       @param {string} next_hop_type - Next hop type (VirtualNetworkGateway/VnetLocal/Internet/VirtualAppliance/None)
 *       @param {string} [next_hop_in_ip_address] - Optional IP address of the next hop
 * 
 * @default {}
 */
 
variable "virtual_networks" {
  description = "A map of virtual networks to create. See terraform.tfvars for an example."
  type = map(object({
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = optional(map(string), {})
    subnets = optional(map(object({
      address_prefixes                              = list(string)
      service_endpoints                             = optional(list(string), [])
      private_endpoint_network_policies_enabled     = optional(bool, true)
      private_link_service_network_policies_enabled = optional(bool, true)
      default_outbound_access_enabled               = optional(bool, true)

      network_security_group = optional(object({
        rules = list(object({
          name                       = string
          priority                   = number
          direction                  = string
          access                     = string
          protocol                   = string
          source_port_range          = string
          destination_port_range     = string
          source_address_prefix      = string
          destination_address_prefix = string
        }))
      }))
      route_table = optional(object({
        routes = list(object({
          name                   = string
          address_prefix         = string
          next_hop_type          = string
          next_hop_in_ip_address = optional(string)
        }))
      }))
    })), {})
  }))
  default = {}
}