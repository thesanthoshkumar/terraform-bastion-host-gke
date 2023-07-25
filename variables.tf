##########################
##        Global        ##
##########################
variable "project_id" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}

variable "region" {
  type        = string
  description = "The location of the project resources being created"
}

variable "zone" {
  type        = string
  description = "The location of the project resources being created"
}
##########################
##     VPC Network      ##
##########################
variable "network_name" {
  type        = string
  description = "The name of the network being created"
}

##########################
##  VPC Subnetwork(s)   ##
##########################
variable "public_subnet_name" {
  type        = string
  description = "The name of the subnetwork being created"
}

variable "public_subnet_ip_range" {
  type        = string
  description = "The IP range of the subnetwork being created"
}

variable "private_subnet_name" {
  type        = string
  description = "The name of the subnetwork being created"
}

variable "private_subnet_ip_range" {
  type        = string
  description = "The IP range of the subnetwork being created"
}

variable "private_secondary_subnet_name_1" {
  type        = string
  description = "The name of the subnetwork being created"
}

variable "private_secondary_subnet_ip_range_1" {
  type        = string
  description = "The IP range of the subnetwork being created"
}

variable "private_secondary_subnet_name_2" {
  type        = string
  description = "The name of the subnetwork being created"
}

variable "private_secondary_subnet_ip_range_2" {
  type        = string
  description = "The IP range of the subnetwork being created"
}

##########################
##      Cloud NAT       ##
##########################
variable "router_name" {
  type        = string
  description = "The name of the router being created"
}

variable "router_nat_name" {
  type        = string
  description = "The name of the router nat being created"
}

variable "nat_address" {
  type        = string
  description = "The name of the external address being created"
}

##########################
##     Bastion Host     ##
##########################

# Service Account
variable "bastion_service_account_id" {
  type        = string
  description = "The Name of the Service account ID for Bastion Host."
}

variable "allow_stopping_for_update" {
  type        = bool
  description = "If you try to update a property that requires stopping the instance without setting this field, the update will fail"
  default     = false
}

# Firewall Rule
variable "firewall_rule_name" {
  type        = string
  description = "The Name of the Firewall rule which is being used for VM"
}

# Compute Instance
variable "bastion_machine_type" {
  type        = string
  description = "The Machine type to create VM"
  default     = "e2-medium"
}

variable "instance_name" {
  type        = string
  description = "The Name of the VM which is being created."
  default     = "bastion-host"
}

variable "members" {
  type        = list(string)
  description = "The List of the Members"
}

#########################
## GKE Private Cluster ##
#########################
variable "gke_nodes_service_account_id" {
  type        = string
  description = "The Name of the Service account ID for GKE nodes."
}

variable "cluster_name" {
  type        = string
  description = "The Name of the GKE Cluster being created"
}

variable "gke_nodes_pool_name" {
  type        = string
  description = "The name of the Node Pool being created."
}

variable "gke_nodes_machine_type" {
  type        = string
  description = "The Name of the Machine Type where Nodes are created"
  default     = "e2-medium"
}
