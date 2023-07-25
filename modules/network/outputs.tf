##########################
##     VPC Network      ##
##########################
output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = google_compute_network.network.id
  description = "The ID of the VPC being created"
}

##########################
##  VPC Subnetwork(s)   ##
##########################
output "subnetworks" {
  value = {
    for subnetwork_key, subnetwork in google_compute_subnetwork.subnetwork : subnetwork.name => {
      name                     = subnetwork["name"]
      id                       = subnetwork["id"]
      self_link                = subnetwork["self_link"]
      ip_cidr_range            = subnetwork["ip_cidr_range"]
      gateway_address          = subnetwork["gateway_address"]
      region                   = subnetwork["region"]
      private_ip_google_access = subnetwork["private_ip_google_access"]
      purpose                  = subnetwork["purpose"]
      secondary_ip_range       = subnetwork["secondary_ip_range"]
    }
  }
  description = "The details of the subnetworks created"
}

##########################
##      Cloud NAT       ##
##########################
output "nat_address" {
  value       = google_compute_address.nat_address.address
  description = "The name of the external address created"
}
