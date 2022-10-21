## email-action-group

This module is for creating email action group.

## Example Usage

Example email file: monitor-action-group.tf

```hcl
module "azure_monitor_action_group" {
  source              ="../../../../modules/tf-az-azure-monitor/email-action-group"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = module.global.location
  region_code         = module.global.region_code
  company_code        = module.global.company_code
  azure_monitor_action_group_short_name = var.azure_monitor_action_group_short_name[terraform.workspace]

  email_receiver_name = var.email_receiver_name[terraform.workspace]
  email_receiver_email_address = var.email_receiver_email_address[terraform.workspace]
  email_receiver_use_common_alert_schema = true

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
        service             = "emailtoops",
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

- `resource_group_name`[*] - The name of the resource group in which to create the email action group. Changing this forces a new resource to be created.

- `short_name`[*] - The short Name of the email action group, very limited character allowed

- `email_receiver name`[*] - name of the email receiver, an action group can have multiple email action groups 

- `email_receiver email_address`[*] - email address where alert to be send, ex: hypercare@severntrent.co.uk

- `email_receiver use_common_alert_schema` - Boolean flag to specify whether common alert schema to be enabled or not. [Default: `true`]

- `tags` - Tags that are used to generate resource names and are applied to the action group.


## Related STW Modules

`tf-az-resourcegroup`
