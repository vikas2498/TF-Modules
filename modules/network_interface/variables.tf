variable "name" {
  description = "Name of the network interface."
  type        = string
}

variable "location" {
  description = "Azure region where the network interface will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the network interface."
  type        = string
}

variable "ip_configurations" {
  description = "Map of IP configurations for the network interface."
  type = map(object({
    subnet_id                     = string
    private_ip_address_allocation = optional(string, "Dynamic")
    private_ip_address            = optional(string)
    public_ip_address_id          = optional(string)
    primary                       = optional(bool, false)
  }))
}

variable "dns_servers" {
  description = "(Optional) List of custom DNS server IP addresses."
  type        = list(string)
  default     = []
}

variable "enable_accelerated_networking" {
  description = "(Optional) Enable accelerated networking. Requires a supported VM size."
  type        = bool
  default     = false
}

variable "enable_ip_forwarding" {
  description = "(Optional) Enable IP forwarding on the NIC."
  type        = bool
  default     = false
}

variable "internal_dns_name_label" {
  description = "(Optional) Internal DNS name label for the NIC."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) Tags to apply to the network interface."
  type        = map(string)
  default     = {}
}