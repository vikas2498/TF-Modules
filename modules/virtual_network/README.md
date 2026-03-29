# terraform-azurerm-virtual-network

Reusable Terraform module that creates an **Azure Virtual Network** with optional inline subnets.

## Registry reference

`https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network`

---

## Usage

```hcl
module "vnet" {
  source = "../../modules/virtual_network"

  name                = "mycompany-vnet-dev"
  location            = "East US"
  resource_group_name = "mycompany-rg-dev-network"
  address_space       = ["10.0.0.0/16"]

  subnets = {
    web = {
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage"]
    }
    app = {
      address_prefixes = ["10.0.2.0/24"]
    }
    db = {
      address_prefixes                          = ["10.0.3.0/24"]
      private_endpoint_network_policies_enabled = false
    }
  }

  tags = {
    environment = "dev"
    project     = "platform"
  }
}
```

---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name of the virtual network | `string` | — | yes |
| `location` | Azure region | `string` | — | yes |
| `resource_group_name` | Resource group to deploy into | `string` | — | yes |
| `address_space` | CIDR blocks for the VNet address space | `list(string)` | — | yes |
| `subnets` | Map of subnets to create inline | `map(object)` | `{}` | no |
| `dns_servers` | Custom DNS server IPs | `list(string)` | `[]` | no |
| `bgp_community` | BGP community attribute | `string` | `null` | no |
| `edge_zone` | Edge zone name | `string` | `null` | no |
| `flow_timeout_in_minutes` | Flow timeout (4–30 minutes) | `number` | `null` | no |
| `tags` | Tags to apply to the virtual network | `map(string)` | `{}` | no |

---

## Outputs

| Name | Description |
|------|-------------|
| `id` | Fully qualified resource ID |
| `name` | Virtual network name |
| `location` | Azure region |
| `resource_group_name` | Resource group name |
| `address_space` | Address space CIDR list |
| `guid` | Virtual network GUID |
| `subnet_ids` | Map of subnet name → subnet ID |

---

## Tags applied automatically

| Key | Value |
|-----|-------|
| `managed_by` | `terraform` |

---

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | ~> 3.0 |
