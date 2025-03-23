# Provider configuration
provider "aws" {
  region = var.aws_region
}

# Create EKS cluster
module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  node_groups     = var.node_groups
}

# Create Jenkins resources
module "jenkins" {
  source = "./modules/jenkins"

  cluster_id            = module.eks.cluster_id
  cluster_endpoint      = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_ca_certificate
  namespace             = "jenkins"
  storage_class_name    = "gp2"
  admin_password        = var.jenkins_admin_password
}

# Create SonarQube resources
module "sonarqube" {
  source = "./modules/sonarqube"

  cluster_id            = module.eks.cluster_id
  cluster_endpoint      = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_ca_certificate
  namespace             = "sonarqube"
  storage_class_name    = "gp2"
  sonarqube_admin_password = var.sonarqube_admin_password
}

# Create Nexus resources
module "nexus" {
  source = "./modules/nexus"

  cluster_id            = module.eks.cluster_id
  cluster_endpoint      = module.eks.cluster_endpoint
  cluster_ca_certificate = module.eks.cluster_ca_certificate
  namespace             = "nexus"
  storage_class_name    = "gp2"
  nexus_admin_password  = var.nexus_admin_password
}