##########################
##     VPC Network      ##
##########################
output "network_name" {
  value       = module.network.network_name
  description = "The name of the network created"
}

##########################
##  VPC Subnetwork(s)   ##
##########################
output "subnetworks" {
  value       = module.network.subnetworks
  description = "The details of the subnets created"
}

##########################
##      Cloud NAT       ##
##########################
output "nat_address" {
  value       = module.network.nat_address
  description = "The name of the external address created"
}

##########################
##     Bastion Host     ##
##########################

output "instance_name" {
  value       = module.bastion_host.instance_name
  description = "The Name of the Compute Instance being created"
}

output "firewall_rule_name" {
  value       = module.bastion_host.firewall_rule_name
  description = "The Name of the Firewall Rule."
}

output "service_account" {
  value       = module.bastion_host.service_account
  description = "The Name of the Service Account"
}

#########################
## GKE Private Cluster ##
#########################

output "gke_cluster_name" {
  value       = module.gke_cluster.cluster_name
  description = "The name of the GKE cluster being created"
}

output "node_pool_name" {
  value       = module.gke_cluster.node_pool_name
  description = "The Name of the Node pool is being created"
}