variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"  # or your preferred region
}
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where EKS will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "node_groups" {
  description = "EKS node group configuration"
  type        = any
}

variable "jenkins_admin_password" {
  description = "Admin password for Jenkins"
  type        = string
  sensitive   = true
}

variable "sonarqube_admin_password" {
  description = "Admin password for SonarQube"
  type        = string
  sensitive   = true
}

variable "nexus_admin_password" {
  description = "Admin password for Nexus"
  type        = string
  sensitive   = true
}



variable "sonarqube_admin_password" {
  description = "Admin password for SonarQube"
  type        = string
  sensitive   = true
}

# Add your variable declarations here

variable "storage_class_name" {
  description = "The storage class name for the persistent volume claim"
  type        = string
    default     = "gp2"

}

# Add your variable declarations here

variable "sonarqube_admin_password" {
  description = "The admin password for SonarQube"
  type        = string
  sensitive = true
}

# Add your variable declarations here

variable "namespace" {
  description = "The namespace to use for SonarQube"
  type        = string
  default     = "sonarqube"
  sensitive = true
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
  description = "Kubernetes namespace for Jenkins"
  type        = string
}

variable "storage_class_name" {
  description = "Storage class name for Jenkins PVC"
  type        = string
}

variable "admin_password" {
  description = "Jenkins admin password"
  type        = string
}