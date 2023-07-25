# Global
variable "project_id" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}

variable "zone" {
  type        = string
  description = "The location of the project resources being created"
}

# Required
variable "instance_name" {
  type        = string
  description = "The Name of the VM which is being created."
  default     = "bastion-host"
}

variable "service_account_id" {
  type        = string
  description = "The Name of the Service account"
}

variable "firewall_rule_name" {
  type        = string
  description = "The Name of the Firewall rule which is being used for VM"
}

variable "network_name" {
  type        = string
  description = "The Name of the Network where VM is being created"
}

variable "subnetwork_name" {
  type        = string
  description = "The Name of the Subnetwork where VM is being created"
}

variable "machine_type" {
  type        = string
  description = "The Machine type to create VM"
  default     = "e2-medium"
}

variable "members" {
  type        = list(string)
  description = "The List of the Members"
}

variable "allow_stopping_for_update" {
  type        = bool
  description = "If you try to update a property that requires stopping the instance without setting this field, the update will fail"
  default     = false
}
