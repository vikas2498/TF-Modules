# This variable defines a map of resource group configurations.
# Each resource group is represented as an object with the following attributes:
# - name (string): The name of the resource group.
# - location (string): The geographical location where the resource group will be created.
# - tags (optional, map of strings): A set of key-value pairs to tag the resource group. Defaults to an empty map.
# - managed_by (optional, string): Specifies the entity managing the resource group. Defaults to null.

variable "resource_groups" {
    description     = "resource groups"

    type = map(object({
        name              = string
        location          = string
        tags              = optional(map(string) , {})
        managed_by        = optional(string, null)
    }))
}