tf-az-publicip
-----

This module is for creating an Azure Public IP address with a public DNS record.

Example Usage
-----

Example public-ip.tf file:

```hcl
module "servicename_environment_region_description_publicip" {
  source   = "../../../modules/tf-az-publicip"
  publicip_label          = "description"
  resource_group_name     = module.servicename_environment_region_resource_group.name
  location                = module.servicename_environment_region_resource_group.location
  allocation_method       = "Dynamic"
  sku                     = "Basic"
  ip_version              = "IPv4"
  idle_timeout_in_minutes = "4"
  reverse_fqdn            = null
  tags                    = var.tags
}
```
The required tags should be populated as lowercase text in the variables.tf file within the execution folder.

Example variables.tf file:

```hcl
# Reminder - all tags should be in lowercase

variable "tags" {
  type = "map"
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

Argument Reference (Variables)
---------
_Variables marked with [*] are mandatory and have to be specified or the module won't function._

 - `publicip_label`[*] - The text string used to identify what resource the public IP is associated with and is used to dynamically build the public ip name from the tags.

 - `resource_group_name`[*] - The name of the resource group in which to create the Public IP address. Changing this forces a new resource to be created.

 - `location`[*] - Specifies the Azure region the resource group will be created in.

 - `allocation_method`[*] - Defines the allocation method for this IP address. Possible values are Static or Dynamic. [Default: "Dynamic"]

 - `sku` - The SKU of the Public IP. Accepted values are Basic and Standard. [Default: "Basic"]

 - `ip_version` - The IP version to use, IPv6 or IPv4. [Default: "IPv4"]

 - `idle_timeout_in_minutes` - Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. [Default: "4"]

 - `reverse_fqdn` - A reverse fully qualified domain name that resolves to this public IP address. If the reverse fqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."

 - `tags`[*] - Tags that are used to generate resource names and are applied to the resource group.

Attributes Reference (Outputs)
---------
In addition to all the arguments above, the following attributes are exported:

 - `id` - The Public IP ID.

 - `ip_address` - The Public IP address value that was allocated.

 - `fqdn` - Fully qualified domain name of the A DNS record associated with the public IP. This is the concatenation of the domain_name_label and the regionalised DNS zone.

Related STW Modules
---------

`tf-az-resourcegroup`