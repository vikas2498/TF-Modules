variable "name" {
  description = "Name of the managed disk."
  type        = string
}

variable "location" {
  description = "Azure region where the managed disk will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the managed disk will be created."
  type        = string
}

variable "storage_account_type" {
  description = "The type of storage to use for the managed disk. e.g. Standard_LRS, Premium_LRS, UltraSSD_LRS"
  type        = string
  default     = "Standard_LRS"
}

variable "disk_size_gb" {
  description = "Specifies the size of the managed disk to create in GB."
  type        = number
}

variable "create_option" {
  description = "The method to use when creating the managed disk. e.g. Empty, Copy, Import"
  type        = string
  default     = "Empty"
}

variable "zone" {
  description = "Specifies the Availability Zone in which the managed disk should be located."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}