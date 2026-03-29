variable "name" {
    description = "Name of the resource group. Must be unique within the Azure subscription."
    type        = string
}

variable "location" {
    description = "Name of the azure region where resource group will be created e.g. West Europe, North Europe"
    type        = string
}

variable "tags" {
    description   = "(optional)tags for resource group"
    type          = map(string)
    default       = {}
}

variable "managed_by" {
    description = "(Optional) ID of the resource that manages this resource group (e.g. a Subscription or Management Group resource ID)."
    type        = string
    default     = null
}