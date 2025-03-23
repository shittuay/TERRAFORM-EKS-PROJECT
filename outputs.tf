output "eks_cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_ids" {
  description = "Security group IDs attached to the EKS cluster"
  value       = module.eks.security_group_ids
}

output "jenkins_url" {
  description = "URL to access Jenkins"
  value       = module.jenkins.jenkins_url
}

output "sonarqube_url" {
  description = "URL to access SonarQube"
  value       = module.sonarqube.sonarqube_url
}

output "nexus_url" {
  description = "URL to access Nexus Repository Manager"
  value       = module.nexus.nexus_url
}