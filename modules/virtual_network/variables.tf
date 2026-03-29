# Virtual Network Module Variables
#
# ## Required Variables
#
# ### name
# # Type:** string
# - **Description:** Name of the virtual network.
#
# ### location
# - **Type:** string
# - **Description:** Azure region where the virtual network will be created.
#
# ### resource_group_name
# - **Type:** string
# - **Description:** Name of the resource group in which to create the virtual network.
#
# ### address_space
# - **Type:** list(string)
# - **Description:** List of CIDR blocks that define the address space of the virtual network.
#
# ## Optional Variables
#
# ### dns_servers
# - **Type:** list(string)
# - **Default:** []
# - **Description:** List of custom DNS server IP addresses.
#
# ### bgp_community
# - **Type:** string
# - **Default:** null
# - **Description:** BGP community attribute.
#
# ### edge_zone
# - **Type:** string
# - **Default:** null
# - **Description:** Name of the edge zone.
#
# ### flow_timeout_in_minutes
# - **Type:** number
# - **Default:** null
# - **Description:** Flow timeout in minutes. Must be between 4 and 30.
#
# ### subnets
# - **Type:** map(object)
# - **Default:** {}
# - **Description:** Map of subnets to create inside the virtual network.
# - **Subnet Object Properties:**
#     - `address_prefixes` (list(string), required): CIDR blocks for the subnet
#     - `service_endpoints` (list(string), optional): Service endpoints to enable
#     - `private_endpoint_network_policies_enabled` (bool, optional): Enable private endpoint network policies
#     - `private_link_service_network_policies_enabled` (bool, optional): Enable private link service network policies
#     - `default_outbound_access_enabled` (bool, optional): Enable default outbound access
#     - `network_security_group` (optional): NSG configuration with security rules
#     - `route_table` (optional): Route table configuration with routes
#
# ### tags
# - **Type:** map(string)
# - **Default:** {}
# - **Description:** Tags to apply to the virtual network.

variable "name" {
  description = "Name of the virtual network."
  type        = string
}

variable "location" {
  description = "Azure region where the virtual network will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the virtual network."
  type        = string
}

variable "address_space" {
  description = "List of CIDR blocks that define the address space of the virtual network."
  type        = list(string)
}

variable "dns_servers" {
  description = "(Optional) List of custom DNS server IP addresses."
  type        = list(string)
  default     = []
}

variable "bgp_community" {
  description = "(Optional) BGP community attribute."
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "(Optional) Name of the edge zone."
  type        = string
  default     = null
}

variable "flow_timeout_in_minutes" {
  description = "(Optional) Flow timeout in minutes. Between 4 and 30."
  type        = number
  default     = null
}

variable "subnets" {
  description = "(Optional) Map of subnets to create inside the virtual network."
  type = map(object({
    address_prefixes                              = list(string)
    service_endpoints                             = optional(list(string), [])
    private_endpoint_network_policies_enabled     = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool, true)
    default_outbound_access_enabled               = optional(bool, true)

    # Add these optional blocks
    network_security_group = optional(object({
      rules = list(object({
        name                     = string
        priority                 = number
        direction                = string
        access                   = string
        protocol                 = string
        source_port_range        = string
        destination_port_range   = string
        source_address_prefix    = string
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
  }))
  default = {}
}

variable "tags" {
  description = "(Optional) Tags to apply to the virtual network."
  type        = map(string)
  default     = {}
}