output "instance_name" {
  value       = google_compute_instance.vm_instance.name
  description = "Instance name which is being created."
}

output "firewall_rule_name" {
  value       = google_compute_firewall.iap_fw.name
  description = "Name of the firewall rule"
}

output "service_account" {
  value       = google_service_account.vm_sa.account_id
  description = "Name of the Service Account"
}
