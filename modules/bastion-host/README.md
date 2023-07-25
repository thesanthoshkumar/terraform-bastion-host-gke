<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.44.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.iap_fw](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.vm_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_iap_tunnel_instance_iam_member.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iap_tunnel_instance_iam_member) | resource |
| [google_project_iam_member.k8s_dev_permission_bindings](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.os_login_bindings](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.iap_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.vm_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.sa_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_compute_image.vm_image](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_stopping_for_update"></a> [allow\_stopping\_for\_update](#input\_allow\_stopping\_for\_update) | If you try to update a property that requires stopping the instance without setting this field, the update will fail | `bool` | `false` | no |
| <a name="input_firewall_rule_name"></a> [firewall\_rule\_name](#input\_firewall\_rule\_name) | The Name of the Firewall rule which is being used for VM | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The Name of the VM which is being created. | `string` | `"bastion-host"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The Machine type to create VM | `string` | `"e2-medium"` | no |
| <a name="input_members"></a> [members](#input\_members) | The List of the Members | `list(string)` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The Name of the Network where VM is being created | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `string` | n/a | yes |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | The Name of the Service account | `string` | n/a | yes |
| <a name="input_subnetwork_name"></a> [subnetwork\_name](#input\_subnetwork\_name) | The Name of the Subnetwork where VM is being created | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The location of the project resources being created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_rule_name"></a> [firewall\_rule\_name](#output\_firewall\_rule\_name) | Name of the firewall rule |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | Instance name which is being created. |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | Name of the Service Account |
<!-- END_TF_DOCS -->