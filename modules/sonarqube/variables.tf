variable "sonarqube_admin_password" {
  description = "Admin password for SonarQube"
  type        = string
  sensitive   = true
}

variable "namespace" {
  description = "Kubernetes namespace for SonarQube"
  type        = string
  default     = "sonarqube"
}

variable "storage_class_name" {
  description = "Storage class name for SonarQube PVC"
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

variable "namespace" {
  description = "Kubernetes namespace for SonarQube deployment"
  type        = string
  default     = "sonarqube"
}

variable "sonarqube_admin_password" {
  description = "Admin password for SonarQube"
  type        = string
  sensitive   = true
}