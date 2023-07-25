# Terraform modules of GKE cluster, Bastion-Host & Network Components

## Overview

It enables the required API services on google cloud.

1. Cloud IAP service

   ```
   iap.googleapis.com
   ```
2. Container service 
   ```
   container.googleapis.com
   ```

3. Compute service
   ```
   compute.googleapis.com
   ```


## Prerequisites steps

1. Create a Cloud Storage Bucket for storing terraform remote state.

   ```shell
   gsutil mb -l <region> gs://<bucket_name>
   ```

2. Enable Object Versioning on Cloud Storage Bucket created.

   ```shell
   gsutil versioning set on gs://<bucket_name>
   ```

3. Enable IAM Service Account Credentials API

   ```shell
   gcloud services enable iamcredentials.googleapis.com
   ```

4. Create a service account

   ```shell
   gcloud iam service-accounts create <service_account_name> \
    --display-name "service_account_name" \
    --description "A service account to create the bastion-host with GKE cluster."
   ```

5. Assign the below permissions to the service account

   - `roles/compute.admin`
   - `roles/container.admin`
   - `roles/storage.admin`

   Use the below command,

   ```shell
   for ROLE in "roles/compute.admin" "roles/container.admin" "roles/storage.admin"
   do
      gcloud projects add-iam-policy-binding <project_name> \
       --member="serviceAccount:<service_account_name>@<project_name>.iam.gserviceaccount.com" \
       --role=$ROLE
   done
   ```

6. Impersonate the service account to use by your user user account.

- Run the following command from a command line

    ```shell
   gcloud config set auth/impersonate_service_account <service_account_name>@<project_name>.iam.gserviceaccount.com
   ```
 - Set the GOOGLE_OAUTH_ACCESS_TOKEN environment variable to the value that is returned by the gcloud auth print-access-token command.

   ```shell
   gcloud auth print-access-token 
   ```
   ```shell
   gcloud iam service-accounts add-iam-policy-binding \
   <service_account_name>@<project_name>.iam.gserviceaccount.com \
   --member="user:<user_email>" \
   --role="roles/iam.serviceAccountTokenCreator"
   ```

7. Connect to Bastion Host VM and install gcloud-cli
   ```shell
   sudo apt-get install apt-transport-https ca-certificates gnupg
   ```
   ```shell
   echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
   ```
   ```shell
   curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
   ```
   ```shell
   sudo apt-get update && sudo apt-get install google-cloud-cli
   ```
   ```shell
   RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y
   ```

8. Connect to Bastion Host VM and install google-cloud-sdk-gke-gcloud-auth-plugin and kubectl
   ```shell
      sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
      sudo apt-get install kubectl
      ```

> **Note:**
>
> - Replace <region> with the region name where GCS bucket can be created.
> - Replace <bucket_name> with the gcs bucket name.
> - Replace <project_name> with your google cloud project name.
> - Replace <service_account_name> with your service account name to use to create infrastructure.
> - Replace <user_email> with your email ID.


## Terraform Documentation

Command to execute

```shell
terraform-docs markdown table . --output-file README.md
```
## To Deploy resources

> **Note:**
> 
> - Update the Backend configuration in terraform.tf file.
> - Replace neccessary values in tfvars.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion_host"></a> [bastion\_host](#module\_bastion\_host) | ./modules/bastion-host | n/a |
| <a name="module_gke_cluster"></a> [gke\_cluster](#module\_gke\_cluster) | ./modules/gke | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_stopping_for_update"></a> [allow\_stopping\_for\_update](#input\_allow\_stopping\_for\_update) | If you try to update a property that requires stopping the instance without setting this field, the update will fail | `bool` | `false` | no |
| <a name="input_bastion_machine_type"></a> [bastion\_machine\_type](#input\_bastion\_machine\_type) | The Machine type to create VM | `string` | `"e2-medium"` | no |
| <a name="input_bastion_service_account_id"></a> [bastion\_service\_account\_id](#input\_bastion\_service\_account\_id) | The Name of the Service account ID for Bastion Host. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The Name of the GKE Cluster being created | `string` | n/a | yes |
| <a name="input_firewall_rule_name"></a> [firewall\_rule\_name](#input\_firewall\_rule\_name) | The Name of the Firewall rule which is being used for VM | `string` | n/a | yes |
| <a name="input_gke_nodes_machine_type"></a> [gke\_nodes\_machine\_type](#input\_gke\_nodes\_machine\_type) | The Name of the Machine Type where Nodes are created | `string` | `"e2-medium"` | no |
| <a name="input_gke_nodes_pool_name"></a> [gke\_nodes\_pool\_name](#input\_gke\_nodes\_pool\_name) | The name of the Node Pool being created. | `string` | n/a | yes |
| <a name="input_gke_nodes_service_account_id"></a> [gke\_nodes\_service\_account\_id](#input\_gke\_nodes\_service\_account\_id) | The Name of the Service account ID for GKE nodes. | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The Name of the VM which is being created. | `string` | `"bastion-host"` | no |
| <a name="input_members"></a> [members](#input\_members) | The List of the Members | `list(string)` | n/a | yes |
| <a name="input_nat_address"></a> [nat\_address](#input\_nat\_address) | The name of the external address being created | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network being created | `string` | n/a | yes |
| <a name="input_private_secondary_subnet_ip_range_1"></a> [private\_secondary\_subnet\_ip\_range\_1](#input\_private\_secondary\_subnet\_ip\_range\_1) | The IP range of the subnetwork being created | `string` | n/a | yes |
| <a name="input_private_secondary_subnet_ip_range_2"></a> [private\_secondary\_subnet\_ip\_range\_2](#input\_private\_secondary\_subnet\_ip\_range\_2) | The IP range of the subnetwork being created | `string` | n/a | yes |
| <a name="input_private_secondary_subnet_name_1"></a> [private\_secondary\_subnet\_name\_1](#input\_private\_secondary\_subnet\_name\_1) | The name of the subnetwork being created | `string` | n/a | yes |
| <a name="input_private_secondary_subnet_name_2"></a> [private\_secondary\_subnet\_name\_2](#input\_private\_secondary\_subnet\_name\_2) | The name of the subnetwork being created | `string` | n/a | yes |
| <a name="input_private_subnet_ip_range"></a> [private\_subnet\_ip\_range](#input\_private\_subnet\_ip\_range) | The IP range of the subnetwork being created | `string` | n/a | yes |
| <a name="input_private_subnet_name"></a> [private\_subnet\_name](#input\_private\_subnet\_name) | The name of the subnetwork being created | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `string` | n/a | yes |
| <a name="input_public_subnet_ip_range"></a> [public\_subnet\_ip\_range](#input\_public\_subnet\_ip\_range) | The IP range of the subnetwork being created | `string` | n/a | yes |
| <a name="input_public_subnet_name"></a> [public\_subnet\_name](#input\_public\_subnet\_name) | The name of the subnetwork being created | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The location of the project resources being created | `string` | n/a | yes |
| <a name="input_router_name"></a> [router\_name](#input\_router\_name) | The name of the router being created | `string` | n/a | yes |
| <a name="input_router_nat_name"></a> [router\_nat\_name](#input\_router\_nat\_name) | The name of the router nat being created | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The location of the project resources being created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_rule_name"></a> [firewall\_rule\_name](#output\_firewall\_rule\_name) | The Name of the Firewall Rule. |
| <a name="output_gke_cluster_name"></a> [gke\_cluster\_name](#output\_gke\_cluster\_name) | The name of the GKE cluster being created |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The Name of the Compute Instance being created |
| <a name="output_nat_address"></a> [nat\_address](#output\_nat\_address) | The name of the external address created |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the network created |
| <a name="output_node_pool_name"></a> [node\_pool\_name](#output\_node\_pool\_name) | The Name of the Node pool is being created |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | The Name of the Service Account |
| <a name="output_subnetworks"></a> [subnetworks](#output\_subnetworks) | The details of the subnets created |
<!-- END_TF_DOCS -->