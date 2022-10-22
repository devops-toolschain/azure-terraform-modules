## webhook-action-group

This module is for creating webhook action group.

## Example Usage

Example webhook action group creation file: servicenow-webhook-action-group.tf

```hcl
module "azure_monitor_action_group" {
  source              ="../../../../modules/tf-az-azure-monitor/webhook-action-group"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = module.global.location
  region_code         = module.global.region_code
  company_code        = module.global.company_code
  azure_monitor_action_group_short_name = var.azure_monitor_action_group_short_name[terraform.workspace]

  web_hook_name                    = var.web_hook_name[terraform.workspace]
  web_hook_service_uri             = var.web_hook_service_uri[terraform.workspace]
  web_hook_use_common_alert_schema = true

  tags                = local.tags
} 
```

The required tags should be populated as lowercase text in the variables.tf file within the execution folder.

Example variables.tf file:

```hcl
# Reminder - all tags should be in lowercase

variable "tags" {
    type = map(string)
    default = {
        service             = "servicenow-webhook",
        iacversion          = "1.0",
        expireson           = "na needs to remain available",
        description         = "azure Monitor email to ops action group",
        maintenancewindow   = "na",
        serviceclassification = "shared infra resource - critical"
        businessowner       = "mark gwynne",
        serviceowner        = "mark gwynne",
        pricecontrol        = "shared services"
        project             = "a6I/11312",
        department          = "technology",
        confidentiality     = "",
        compliance          = "",
        hoursofoperation    = "24*7*365",
    }
}
```

## Argument Reference (Variables)

_Variables marked with [*] are mandatory and have to be specified or the module won't function._

- `resource_group_name`[*] - The name of the resource group in which to create the webhook action group. Changing this forces a new resource to be created.

- `short_name`[*] - The short Name of the webhook action group, very limited character allowed

- `webhook_receiver name`[*] - name of the webhook receiver, an action group can have multiple  action within it 

- `webhook_receiver service_uri`[*] - service uri address where alert to be send, ex: https://severntrentplc.service-now.com/api/setp/

- `webhook_receiver use_common_alert_schema` - Boolean flag to specify whether common alert schema to be enabled or not. [Default: `true`]

- `tags` - Tags that are used to generate resource names and are applied to the action group.


## Related STW Modules

`tf-az-resourcegroup`
