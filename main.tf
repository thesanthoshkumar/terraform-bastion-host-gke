module "network" {
  source = "./modules/network"

  # Global
  project_id = var.project_id
  region     = var.region

  # Network
  network_name = var.network_name

  # Subnetworks
  subnets = [
    {
      name              = var.public_subnet_name
      ip_cidr_range     = var.public_subnet_ip_range
      region            = var.region
      flow_logs_options = [{}]
    },
    {
      name          = var.private_subnet_name
      ip_cidr_range = var.private_subnet_ip_range
      region        = var.region
      secondary_ip_ranges = [
        {
          range_name    = var.private_secondary_subnet_name_1
          ip_cidr_range = var.private_secondary_subnet_ip_range_1
        },
        {
          range_name    = var.private_secondary_subnet_name_2
          ip_cidr_range = var.private_secondary_subnet_ip_range_2
        }
      ]
      flow_logs_options = [{}]
    }
  ]

  # NAT Gateway
  router_name     = var.router_name
  router_nat_name = var.router_nat_name
  nat_address     = var.nat_address
}

module "bastion_host" {
  source = "./modules/bastion-host"

  # Global
  project_id = var.project_id
  zone       = var.zone

  allow_stopping_for_update = var.allow_stopping_for_update

  # Required
  # Service Account
  service_account_id = var.bastion_service_account_id

  # Compute instance
  instance_name = var.instance_name
  machine_type  = var.bastion_machine_type
  members       = var.members

  # Firewall Rule
  firewall_rule_name = var.firewall_rule_name
  network_name       = var.network_name
  subnetwork_name    = var.public_subnet_name

  depends_on = [
    module.network
  ]
}

#GKE Private Cluster

module "gke_cluster" {
  source = "./modules/gke"

  #Global
  project_id = var.project_id
  region     = var.region

  #Required
  service_account_id = var.gke_nodes_service_account_id

  network_name = var.network_name
  subnet_name  = var.private_subnet_name

  services_secondary_range_name = var.private_secondary_subnet_name_1
  cluster_secondary_range_name  = var.private_secondary_subnet_name_2

  master_authorized_networks = [{
    name          = var.public_subnet_name
    ip_cidr_range = var.public_subnet_ip_range
  }]

  cluster_name   = var.cluster_name
  node_pool_name = var.gke_nodes_pool_name
  machine_type   = var.gke_nodes_machine_type

  depends_on = [
    module.network
  ]
}
