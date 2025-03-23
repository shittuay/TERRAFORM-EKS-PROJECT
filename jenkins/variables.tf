variable "jenkins_admin_password" {
  description = "Admin password for Jenkins"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "storage_class_name" {
  description = "Storage class name for Jenkins PVC"
  type        = string
  default     = "gp2"
}

variable "sonarqube_admin_password" {
  description = "Admin password for SonarQube"
  type        = string
  sensitive   = true
}
