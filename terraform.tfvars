##########################
##        Global        ##
##########################
project_id = "project_name"
region     = "region"
zone       = "zone"

##########################
##     VPC Network      ##
##########################
network_name = "project_name-network"

##########################
##  VPC Subnetwork(s)   ##
##########################

# Public
public_subnet_name     = "project_name-public-subnet"
public_subnet_ip_range = "10.100.0.0/24"

# Private
private_subnet_name     = "project_name-private-subnet"
private_subnet_ip_range = "10.100.1.0/24"

# Private Secondary Range for k8s services
private_secondary_subnet_name_1     = "project_name-k8s-services-range"
private_secondary_subnet_ip_range_1 = "10.100.4.0/23"

# Private Secondary Range for k8s pods
private_secondary_subnet_name_2     = "project_name-k8s-pods-range"
private_secondary_subnet_ip_range_2 = "10.100.128.0/17"

##########################
##      Cloud NAT       ##
##########################

router_name     = "project_name-nat-router"
router_nat_name = "project_name-nat-gw"
nat_address     = "project_name-nat-address"

##########################
##    Bastion Host      ##
##########################

bastion_service_account_id = "project_name-bastion-sa"
firewall_rule_name         = "project_name-allow-ssh-via-iap"

bastion_machine_type = "e2-medium"
instance_name        = "project_name-bastion-vm"

members = [
  "user:Santhosh.kumar@gmail.com",
]

allow_stopping_for_update = true

#########################
## GKE Private Cluster ##
#########################

gke_nodes_service_account_id = "project_name-gke-no-sa"
cluster_name                 = "project_name-gke"
gke_nodes_pool_name          = "project_name-gke-node-pool"
gke_nodes_machine_type       = "e2-medium"
