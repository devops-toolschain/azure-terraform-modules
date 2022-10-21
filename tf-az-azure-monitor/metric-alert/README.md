## metric-alert

This module is for creating metric alert.

## Example Usage

Example shared-azure-monitor/vm-metric-alert/prod/vm-metric-alert.tf file:

```hcl
module "azure_monitor_vm_metric_alert" {
  source   = "../../../../modules/tf-az-azure-monitor/metric-alert"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  azure_monitor_metric_alert_action_id = data.azurerm_monitor_action_group.actiongroupemailtoops.id
  vm_metric_alerts = local.vm_common_metric_alerts
}
```

The required tags should be populated as lowercase text in the variables.tf file within the execution folder.

Example variables.tf file:

```hcl
# Reminder - all tags should be in lowercase

variable "tags" {
  type = map
  default = {
    service           = "vmmetricalert"
    environment       = "prod"
    iacversion        = "1.0"
    expireson         = "na"
    description       = "azure Monitor VM metric alert"
    maintenancewindow = "n/a"
    hoursofoperation  = "16/5/365"
    businessowner     = "mark.gwynne@severntrent.co.uk"
    costcentre        = "a6I/11312"
    project           = "stw cloud migration"
    department        = "technology"
    confidentiality   = "NA"
    compliance        = "NA"
  }
}
```

## Argument Reference (Variables)

_Variables marked with [*] are mandatory and have to be specified or the module won't function._

- `name`[*] - The name of the metric alert.

- `resource_group_name`[*] - The name of the resource group in which to create the alert. Changing this forces a new resource to be created.

- `tags` - Tags that are used to generate resource names and are applied to the metric alert.

- `scopes`[*] - resource id to which metric alert to be applied

- `description` - description of the metric alert

- `severity` - The severity of the Metric Alert. Possible values are 0, 1, 2, 3 and 4

- `frequency` - The evaluation frequency of the Metric Alert, Possible values are PT1M, PT5M, PT15M, PT30M and PT1H.

- `window_size`[*] - The period of time that is used to monitor alert activity. This value must be greater than frequency. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. 

- `metric_namespace`[*] - metric namespaces to be monitored, ex Average_% Free Space
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcomputevirtualmachines 

- `metric_name`[*] - One of the metric names to be monitored

- `aggregation`[*] - The statistic that runs over the metric values. Possible values are Average, Count, Minimum, Maximum and Total

- `operator`[*] - The criteria operator. Possible values are Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan and LessThanOrEqual

- `threshold`[*] - The criteria threshold numeric value that activates the alert

- `dimension_name` - name of the dimension, 

- `dimension_operator` - The dimension operator. Possible values are Include and Exclude

- `values` - The list of dimension values

- `enabled` - Boolean flag to specify alert enabled. [Default: `true`]


## Related STW Modules

`tf-az-resourcegroup`
