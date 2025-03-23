variable "nexus_admin_password" {
  description = "Admin password for Nexus"
  type        = string
  sensitive   = true
}

variable "namespace" {
  description = "Kubernetes namespace for Nexus"
  type        = string
  default     = "nexus"
}

variable "storage_class_name" {
  description = "Storage class name for Nexus PVC"
  type        = string
  default     = "gp2"
}

variable "cluster_id" {
  description = "EKS cluster ID"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "EKS cluster CA certificate"
  type        = string
}