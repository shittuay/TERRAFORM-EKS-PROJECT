# AWS Region
aws_region = "us-west-2"

# EKS Cluster Configuration
cluster_name    = "devops-cluster"
cluster_version = "1.27"

# VPC and Subnet information
vpc_id     = "vpc-0fa4b7f97227e5a5c"  # Replace with your actual VPC ID
subnet_ids = [
  "subnet-08761d5554a32347a",         # Replace with your actual subnet IDs
  "subnet-081337cd3932f3d01",
  "subnet-0a9c90025a641ae75"
]

# EKS Node Groups Configuration
node_groups = {
  default_node_group = {
    desired_capacity = 2
    max_capacity     = 3
    min_capacity     = 1
    instance_types   = ["t3.medium"]
    disk_size        = 50
  },
  application_node_group = {
    desired_capacity = 2
    max_capacity     = 5
    min_capacity     = 1
    instance_types   = ["t3.large"]
    disk_size        = 100
    labels = {
      role = "application"
    }
  }
}

# Service Admin Passwords
# In a production environment, you would use a secrets manager instead of storing these in plain text
jenkins_admin_password   = "ChangeMe123!"       # Replace with a secure password
sonarqube_admin_password = "SonarPassword123!"  # Replace with a secure password
nexus_admin_password     = "NexusPassword123!"  # Replace with a secure password
