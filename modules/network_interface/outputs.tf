output "id" {
  description = "The ID of the network interface."
  value       = azurerm_network_interface.this.id
}

output "name" {
  description = "The name of the network interface."
  value       = azurerm_network_interface.this.name
}

output "private_ip_address" {
  description = "The primary private IP address of the network interface."
  value       = azurerm_network_interface.this.private_ip_address
}

output "private_ip_addresses" {
  description = "List of all private IP addresses assigned to the network interface."
  value       = azurerm_network_interface.this.private_ip_addresses
}

output "mac_address" {
  description = "The MAC address of the network interface."
  value       = azurerm_network_interface.this.mac_address
}