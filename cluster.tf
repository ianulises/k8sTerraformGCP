resource "google_container_cluster" "default" {
  name                = var.clusterName
  location            = var.location
  initial_node_count  = var.nodeCount
  deletion_protection = false

  node_config {
    preemptible  = true
    machine_type = var.machineType
  }
}