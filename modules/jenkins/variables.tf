variable "cluster_id" {
  description = "The ID of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "The CA certificate of the EKS cluster"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for Jenkins"
  type        = string
}

variable "storage_class_name" {
  description = "Storage class name for Jenkins PVC"
  type        = string
}

variable "jenkins_admin_password" {
  description = "Admin password for Jenkins"
  type        = string
  sensitive   = true
}