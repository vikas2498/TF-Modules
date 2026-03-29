/*
 * This file defines the resource groups configuration for Terraform.
 * 
 * The `resource_groups` variable is a map containing multiple resource group definitions.
 * Each resource group is identified by a unique key (e.g., D03, D04, net) and includes:
 * 
 * - `name`: The name of the resource group.
 * - `location`: The Azure region where the resource group will be created.
 * - `tags`: A set of key-value pairs used to tag the resource group for identification and organization.
 *   - `project`: The project associated with the resource group.
 *   - `environment`: The environment type (e.g., Dev).
 *   - `SID`: A unique identifier for the resource group.
 * 
 * Example resource groups:
 * - D03: Represents a development resource group in West Europe with the SID "D03".
 * - D04: Represents another development resource group in West Europe with the SID "D04".
 * - net: Represents a network-related resource group in West Europe with the SID "NetWork".
 */


resource_groups = {
    D03 = {
        name     = "EA-WE-D-RG-D03"
        location = "West Europe"
        tags = {
            project     = "Platform"
            environment = "Dev"
            SID         = "D03"
        }
    }

    D04 = {
        name     = "EA-WE-D-RG-D04"
        location = "West Europe"
        tags = {
             project      = "Platform"
             environment  = "Dev"
             SID          = "D04"
        }
    }

    net = {
        name     = "EA-WE-D-RG-Net"
        location = "West Europe"
        tags = {
             project      = "Platform"
             environment  = "Dev"
             SID          = "NetWork"
        }
    }

}