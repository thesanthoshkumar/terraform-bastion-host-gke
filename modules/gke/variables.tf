# Global
variable "project_id" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}

variable "region" {
  type        = string
  description = "The location of the project resources being created"
}

variable "network_name" {
  type        = string
  description = "The name of the network GKE being created"
}

# Required
variable "service_account_id" {
  type        = string
  description = "The Name of the Service account ID for GKE Nodes."
}

variable "cluster_name" {
  type        = string
  description = "The Name of the GKE Cluster being created"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnetwork where GKE being created"
}

variable "node_pool_name" {
  type        = string
  description = "The name of the Node Pool being created."
}

variable "machine_type" {
  type        = string
  description = "The Name of the Machine Type where Nodes are created"
  default     = "n1-standard-2"
}

variable "cluster_secondary_range_name" {
  type        = string
  description = "The Name of the secondary CIDR range name for cluster Pod IPs"
}

variable "services_secondary_range_name" {
  type        = string
  description = "The Name of the secondary CIDR range name for service network IPs"
}

variable "master_authorized_networks" {
  type = list(object({
    name          = optional(string)
    ip_cidr_range = string
  }))
  description = "The details of master authorised networks for GKE Cluster"
}
