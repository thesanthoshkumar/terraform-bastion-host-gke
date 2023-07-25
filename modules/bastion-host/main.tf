##########################
##     Bastion Host     ##
##########################

resource "google_project_service" "iap_service" {
  project = var.project_id
  service = "iap.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

# Custom IAM service account for bastion host
resource "google_service_account" "vm_sa" {
  project = var.project_id

  account_id   = var.service_account_id
  display_name = "Bastion Host SA"
  description  = "A custom service account for bastion host."
}

resource "google_service_account_iam_binding" "sa_user" {
  service_account_id = google_service_account.vm_sa.id
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = var.members
}

# Enabling OS Login
resource "google_project_iam_member" "os_login_bindings" {

  project = var.project_id
  role    = "roles/compute.osLogin"
  member  = format("serviceAccount:%s", google_service_account.vm_sa.email)
}

resource "google_project_iam_member" "k8s_dev_permission_bindings" {

  project = var.project_id
  role    = "roles/container.admin"
  member  = format("serviceAccount:%s", google_service_account.vm_sa.email)
}

# Create the Bastion Host
data "google_compute_image" "vm_image" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "vm_instance" {
  project = var.project_id
  zone    = var.zone

  name         = var.instance_name
  machine_type = var.machine_type

  allow_stopping_for_update = var.allow_stopping_for_update

  network_interface {
    network            = var.network_name
    subnetwork         = var.subnetwork_name
    subnetwork_project = var.project_id
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.vm_image.self_link
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }

  tags = [
    "public-access-via-iap"
  ]
}

# Cloud IAP Configuration
resource "google_compute_firewall" "iap_fw" {
  project = var.project_id

  name    = var.firewall_rule_name
  network = var.network_name

  source_ranges = [
    "35.235.240.0/20"
  ]

  allow {
    protocol = "tcp"
    ports = [
      "22"
    ]
  }

  target_tags = [
    "public-access-via-iap"
  ]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_iap_tunnel_instance_iam_member" "instance" {
  for_each = toset(var.members)

  project  = var.project_id
  instance = google_compute_instance.vm_instance.name
  zone     = var.zone
  role     = "roles/iap.tunnelResourceAccessor"

  member = each.key

  depends_on = [
    google_project_service.iap_service
  ]
}
