## tf-az-log-analytics-workspace

This module is for creating an Azure Log Analytics Workspace named to STW standards using tags for consistency.

## Example Usage

Example log-analytics-workspace.tf file:

```hcl
module "servicename_environment_logaw" {
  source              = "../../../modules/tf-az-log-analytics-workspace"
  resource_group_name  = module.servicename_environment_region_resource_group.name
  location             = module.servicename_environment_region_resource_group.location
  retention_in_days   = 30
  tags                = var.tags
}
```

The required tags should be populated as lowercase text in the variables.tf file within the execution folder.

Example variables.tf file:

```hcl
# Reminder - all tags should be in lowercase

variable "tags" {
  type = map
  default = {
    service           = "servicename" # This should be no longer than characters with no spaces
    environment       = "dev" # This should be one of prod/preprod/test/dev
    iacversion        = "1.0"
    expireson         = "n/a"
    description       = "project x requested by person/train y, key technical contacts firstname1 surname1 & firstname2 surname2"
    maintenancewindow = "18:00-08:00 daily"
    hoursofoperation  = "08:00-18:00 mon-fri"
    businessowner     = "firstname.surname@severntrent.co.uk"
    costcentre        = "a6i/sapcode"
    project           = "project x - jira reference xxxx-xx"
    department        = "technology"
    confidentiality   = ""
    compliance        = ""
  }
}
```

## Argument Reference (Variables)

_Variables marked with [*] are mandatory and have to be specified or the module won't function._

- `resource_group_name`[*] - The name of the resource group in which the Log Analytics Workspace is created. Changing this forces a new resource to be created.

- `location`[*] - Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

- `sku`[*] - Specifies the Sku of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, and PerGB2018 (new Sku as of 03-04-2018)." # NOTE: A new pricing model took effect on 03-04-2018, which requires the SKU PerGB2018.

- `retention_in_days`[*] - The workspace data retention in days. Possible values range between 30 and 730.

- `tags`[*] - Tags applied to the Log Analytics Workspace.

## Attributes Reference (Outputs)

In addition to all the arguments above, the following attributes are exported:

- `id` - The Log Analytics Workspace ID.

- `name` - The name of the Log Analytics Workspace.

- `primary_shared_key` - The Primary shared key for the Log Analytics Workspace.

- `secondary_shared_key` - The Secondary shared key for the Log Analytics Workspace.

- `workspace_id` - The Workspace (or Customer) ID for the Log Analytics Workspace

- `portal_url` - The Portal URL for the Log Analytics Workspace.

## Related STW Modules

`tf-az-resourcegroup`
