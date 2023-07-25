#########################
## GKE Private Cluster ##
#########################

resource "google_project_service" "container_service" {
  project = var.project_id
  service = "container.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_service_account" "gke_nodes_sa" {
  project = var.project_id

  account_id   = var.service_account_id
  display_name = "GKE Nodes SA"
  description  = "A custom service account for GKE Nodes."
}

resource "google_container_cluster" "gke_cluster" {
  #Global
  project  = var.project_id
  location = var.region
  network  = var.network_name

  #Required
  name       = var.cluster_name
  subnetwork = var.subnet_name

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {

      for_each = length(var.master_authorized_networks) > 0 ? var.master_authorized_networks : []

      content {
        display_name = cidr_blocks.value.name
        cidr_block   = cidr_blocks.value.ip_cidr_range
      }
    }
  }

  depends_on = [
    google_project_service.container_service
  ]
}

resource "google_container_node_pool" "gke_nodes" {
  # Global
  location = var.region
  project  = var.project_id

  # Required
  name    = var.node_pool_name
  cluster = google_container_cluster.gke_cluster.name

  node_count = 1

  node_config {
    machine_type    = var.machine_type
    service_account = google_service_account.gke_nodes_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  autoscaling {
    min_node_count = 1
    max_node_count = 6
  }
}
