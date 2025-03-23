variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "devops-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_groups" {
  description = "Map of EKS node group configurations"
  type        = map(any)
  default = {
    default_node_group = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
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

variable "nexus_admin_password" {
  description = "Admin password for Nexus repository manager"
  type        = string
  sensitive   = true
}