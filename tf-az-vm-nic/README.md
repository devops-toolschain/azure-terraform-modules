tf-az-vm-nic
-----

This module is for creating an Azure Virtual Machine Network Interface named to STW standards using tags for consistency.

Example Usage
-----

Example vm-nic.tf file:

```hcl
module "servicename_environment_region_virtualmachine_nic" {
  source                        = "../../../modules/tf-az-vm-nic"
  virtual_machine_name          = "vmname"
  nic_number                    = "0"
  resource_group_name           = module.servicename_environment_region_resource_group.name
  location                      = module.servicename_environment_region_resource_group.location
  network_security_group_id     = module.servicename_environment_vmname_nsg.id
  internal_dns_name_label       = null
  enable_ip_forwarding          = "false"
  enable_accelerated_networking = "false"
  dns_servers                   = null
  subnet_id                     = module.servicename_environment_region_description_subnet.id
  private_ip_address            = null
  private_ip_address_allocation = "Dynamic"
  public_ip_address_id          = null
  primary                       = null
  secondary_private_ips         = var.secondary_private_ips
  tags                          = var.tags
}
```
The required tags should be populated as lowercase text in the variables.tf file within the execution folder.

Example variables.tf file:

```hcl

# Variable to add multiple secondry IPs

variable "secondary_private_ips" {
    type = list(object({
        name_suffix                 = string
        ip_address                  = string
        ip_allocation               = string
        public_ip_address_id        = string
    }))
    default = [
        {
            name_suffix          = "ip-1"
            ip_address           = "10.245.228.16"
            ip_allocation        = "Static"
            public_ip_address_id = null
        },
        {
            name_suffix          = "ip-2"
            ip_address           = null
            ip_allocation        = "Dynamic"
            public_ip_address_id = null
        },
        {
            name_suffix          = "ip-3"
            ip_address           = null
            ip_allocation        = "Dynamic"
            public_ip_address_id = null
        }
    ]
}

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

 - `virtual_machine_name`[*] - The name of the Virtual Machine the Network Interface will be attached to.  USed to help generate the NIC name.

 - `nic_number` - The number of the Network Interface to be attached to the VM starting with 0. [Default: "0"]

 - `resource_group_name`[*] - The name of the resource group in which to create the Network Interface. Changing this forces a new resource to be created.

 - `location`[*] - Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

 - `network_security_group_id` - The ID of the Network Security Group to associate with the network interface.

 - `internal_dns_name_label` - Relative DNS name for this NIC used for internal communications between VMs in the same VNet."

 - `network_security_group_id` - The ID of the Network Security Group to associate with the network interface.

 - `enable_ip_forwarding` - Enables IP Forwarding on the NIC. [Default: "false"]

 - `enable_accelerated_networking` - Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported. Refer to Create a Virtual Machine with Accelerated Networking. [Default: "false"]

 - `dns_servers` - List of DNS servers IP addresses to use for this NIC, overrides the VNet-level server list. [Default: null]

 - `subnet_id` - The resource ID of the Subnet the NIC will be attached to.

 - `private_ip_address` - Static IP Address. [Default: null]

 - `private_ip_address_allocation` - Defines how a private IP address is assigned. Options are Static or Dynamic. [Default: "Dynamic"]

 - `public_ip_address_id` - Reference to a Public IP Address to associate with this NIC. [Default: null

 - `primary` - Is this the Primary Network Interface? If set to true this should be the first ip_configuration in the array. [Default: null]

- `secondary_private_ips` - (Optional) A list of secondry IP address required to add to the NIC [Default: []]

Attributes Reference (Outputs)
---------
In addition to all the arguments above, the following attributes are exported:

 - `id` - The Virtual Network Interface ID.

 - `mac_address` - The media access control (MAC) address of the network interface.

 - `private_ip_address` - The first private IP address of the network interface.

 - `private_ip_addresses` - The private IP addresses of the network interface.

 - `virtual_machine_id` - Reference to a VM with which this NIC has been associated.

 - `applied_dns_servers` - If the VM that uses this NIC is part of an Availability Set, then this list will have the union of all DNS servers from all NICs that are part of the Availability Set.
 

Related STW Modules
---------

`tf-az-resourcegroup`
`tf-az-vnet-subnet`
`tf-az-nsg-vm`