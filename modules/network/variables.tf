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

##########################
##     VPC Network      ##
##########################
variable "network_name" {
  type        = string
  description = "The name of the network being created"
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "routing_mode" {
  type        = string
  description = "The network routing mode (default 'GLOBAL')"
  default     = "REGIONAL"
  validation {
    condition     = var.routing_mode == "REGIONAL" || var.routing_mode == "GLOBAL"
    error_message = "The Values must be either `REGIONAL` or `GLOBAL`"
  }
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = false
}

variable "mtu" {
  type        = number
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively."
  default     = 1460
}

##########################
##  VPC Subnetwork(s)   ##
##########################
variable "subnets" {
  type = list(object({
    name                  = string
    ip_cidr_range         = string
    region                = string
    description           = optional(string)
    purpose               = optional(string)
    role                  = optional(string)
    private_google_access = optional(bool)
    flow_logs_options = optional(list(object({
      flow_logs_interval = optional(string)
      flow_logs_sampling = optional(string)
      flow_logs_metadata = optional(string)
    })))
    secondary_ip_ranges = optional(list(object({
      range_name    = string
      ip_cidr_range = string
    })))
  }))
  description = "The list of the Subnetworks being created."
}

##########################
##      Cloud NAT       ##
##########################
variable "nat_address" {
  type        = string
  description = "The name of the external address being created"
}

variable "router_name" {
  type        = string
  description = "The name of the router being created"
}

variable "router_description" {
  type        = string
  description = "The description of the router being created"
  default     = ""
}

variable "router_nat_name" {
  type        = string
  description = "The name of the router nat being created"
}
