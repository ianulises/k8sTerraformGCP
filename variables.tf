variable "projectId" {
  type    = string
  description = "Project ID"
  default = "constant-rig-444419-v6"
}

variable "location" {
  type    = string
  description = "Location"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "clusterName" {
  type        = string
  description = "Cluster name"
}

variable "machineType" {
  type        = string
  description = "Node Instance machine type"
}

variable "nodeCount" {
  type        = number
  description = "Number of nodes in the node pool"
  default = 1
}

variable "dockerImage" {
  type        = string
  description = "Docker Image"
}
