variable "name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region where the resource group will be created."
  type        = string
}

variable "use_existing" {
  description = "Set to true if the resource group already exists and should not be created."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the resource group."
  type        = map(string)
  default     = {}
}