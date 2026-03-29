/*
This module block is used to create multiple Azure Resource Groups using the Terraform module located at "../../modules/resource_group".

Inputs:
- var.resource_groups: A map of resource group configurations where each key represents a unique identifier, and the value contains the following attributes:
    - name: The name of the resource group.
    - location: The Azure region where the resource group will be created.
    - tags: A map of tags to associate with the resource group.
    - managed_by: An optional string indicating the entity managing the resource group.

Outputs:
- This module does not explicitly define outputs in this block, but the outputs depend on the module's implementation.

Usage:
- Ensure that the variable `var.resource_groups` is defined in the parent module with the required structure.
- The `for_each` construct is used to iterate over the `var.resource_groups` map, creating a resource group for each entry.
*/

module "resource_groups" {
    source = "../../modules/resource_group"
    for_each    = var.resource_groups
    name        = each.value.name
    location    = each.value.location
    tags        = each.value.tags
    managed_by  = each.value.managed_by
}