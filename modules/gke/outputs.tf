output "cluster_name" {
  value       = google_container_cluster.gke_cluster.name
  description = "The Name of the cluster being created"
}

output "node_pool_name" {
  value       = google_container_node_pool.gke_nodes.name
  description = "The Name of the Node pool being created"
}
