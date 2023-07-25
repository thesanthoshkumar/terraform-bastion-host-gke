##########################
##     VPC Network      ##
##########################
resource "google_project_service" "compute_network_service" {
  project = var.project_id
  service = "compute.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_compute_network" "network" {
  # Required
  project = var.project_id
  name    = var.network_name

  # Optional
  description                     = var.description
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_internet_gateway_routes
  mtu                             = var.mtu

  depends_on = [
    google_project_service.compute_network_service
  ]
}

##########################
##  VPC Subnetwork(s)   ##
##########################
locals {
  subnets = {
    for x in var.subnets : x.name => x
  }
}

resource "google_compute_subnetwork" "subnetwork" {
  for_each = local.subnets

  # Required
  project = var.project_id
  network = var.network_name

  name          = each.value.name
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region

  # Optional
  description              = lookup(each.value, "description") != null ? each.value.description : ""
  purpose                  = lookup(each.value, "purpose") != null ? each.value.purpose : "PRIVATE"
  role                     = lookup(each.value, "role") != null ? each.value.role : "ACTIVE"
  private_ip_google_access = lookup(each.value, "private_google_access") != null ? each.value.private_google_access : true

  dynamic "log_config" {
    for_each = length(lookup(each.value, "flow_logs_options") != null ? each.value.flow_logs_options : []) == 1 ? each.value.flow_logs_options : []

    content {
      aggregation_interval = lookup(log_config.value, "flow_logs_interval") != null ? log_config.value.flow_logs_interval : "INTERVAL_5_SEC"
      flow_sampling        = lookup(log_config.value, "flow_logs_sampling") != null ? log_config.value.flow_logs_sampling : "0.5"
      metadata             = lookup(log_config.value, "flow_logs_metadata") != null ? log_config.value.flow_logs_metadata : "INCLUDE_ALL_METADATA"
    }
  }

  dynamic "secondary_ip_range" {
    for_each = length(lookup(each.value, "secondary_ip_ranges") != null ? each.value.secondary_ip_ranges : []) > 0 ? each.value.secondary_ip_ranges : []

    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }

  depends_on = [
    google_compute_network.network
  ]
}

resource "google_compute_address" "nat_address" {
  name         = var.nat_address
  project      = var.project_id
  region       = var.region
  address_type = "EXTERNAL"

  depends_on = [
    google_compute_network.network
  ]
}

resource "google_compute_router" "router" {
  # Global
  project = var.project_id
  region  = var.region
  network = google_compute_network.network.id

  # Required
  name = var.router_name

  # Optional
  description = var.router_description != null ? var.router_description : ""

  bgp {
    asn            = 64514
    advertise_mode = "CUSTOM"
    dynamic "advertised_ip_ranges" {
      for_each = {
        for subnet in google_compute_subnetwork.subnetwork : subnet.name => subnet
      }

      content {
        range = advertised_ip_ranges.value.ip_cidr_range
      }
    }
  }

  depends_on = [
    google_compute_network.network
  ]
}

resource "google_compute_router_nat" "router_nat" {
  # Global
  project = var.project_id
  region  = var.region

  # Required
  name   = var.router_nat_name
  router = google_compute_router.router.name

  # Optional
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  nat_ips = [
    google_compute_address.nat_address.id
  ]

  dynamic "subnetwork" {
    for_each = {
      for subnet in google_compute_subnetwork.subnetwork : subnet.name => subnet
    }

    content {
      name                    = subnetwork.value.self_link
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }

  log_config {
    enable = true
    filter = "ALL"
  }

  depends_on = [
    google_compute_network.network,
    google_compute_router.router
  ]
}
