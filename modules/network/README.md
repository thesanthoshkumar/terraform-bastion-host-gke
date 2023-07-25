<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.nat_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.router_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_project_service.compute_network_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| <a name="input_delete_default_internet_gateway_routes"></a> [delete\_default\_internet\_gateway\_routes](#input\_delete\_default\_internet\_gateway\_routes) | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| <a name="input_mtu"></a> [mtu](#input\_mtu) | The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively. | `number` | `1460` | no |
| <a name="input_nat_address"></a> [nat\_address](#input\_nat\_address) | The name of the external address being created | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network being created | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The location of the project resources being created | `string` | n/a | yes |
| <a name="input_router_description"></a> [router\_description](#input\_router\_description) | The description of the router being created | `string` | `""` | no |
| <a name="input_router_name"></a> [router\_name](#input\_router\_name) | The name of the router being created | `string` | n/a | yes |
| <a name="input_router_nat_name"></a> [router\_nat\_name](#input\_router\_nat\_name) | The name of the router nat being created | `string` | n/a | yes |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network routing mode (default 'GLOBAL') | `string` | `"REGIONAL"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The list of the Subnetworks being created. | <pre>list(object({<br>    name                  = string<br>    ip_cidr_range         = string<br>    region                = string<br>    description           = optional(string)<br>    purpose               = optional(string)<br>    role                  = optional(string)<br>    private_google_access = optional(bool)<br>    flow_logs_options = optional(list(object({<br>      flow_logs_interval = optional(string)<br>      flow_logs_sampling = optional(string)<br>      flow_logs_metadata = optional(string)<br>    })))<br>    secondary_ip_ranges = optional(list(object({<br>      range_name    = string<br>      ip_cidr_range = string<br>    })))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_address"></a> [nat\_address](#output\_nat\_address) | The name of the external address created |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The ID of the VPC being created |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC being created |
| <a name="output_subnetworks"></a> [subnetworks](#output\_subnetworks) | The details of the subnetworks created |
<!-- END_TF_DOCS -->
