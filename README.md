DevOps Infrastructure with Terraform
This project provides Terraform configurations to deploy a complete DevOps infrastructure on Amazon EKS. The infrastructure includes:

Amazon EKS Cluster
Jenkins CI/CD server
SonarQube for code quality analysis
Nexus Repository Manager for artifact storage

Architecture
The infrastructure is organized as Terraform modules:

EKS Module: Creates and configures the Kubernetes cluster on AWS
Jenkins Module: Deploys Jenkins on the EKS cluster
SonarQube Module: Deploys SonarQube on the EKS cluster
Nexus Module: Deploys Nexus Repository Manager on the EKS cluster

All services are deployed within dedicated namespaces on the EKS cluster and configured to work together for a complete CI/CD pipeline.
Prerequisites

Terraform (v1.0.0+)
AWS CLI (configured with appropriate credentials)
kubectl
helm

Project Structure
Copyterraform-project/
├── main.tf          # Main configuration file that calls all modules
├── variables.tf     # Project-wide variables
├── outputs.tf       # Project-wide outputs
├── terraform.tfvars # Variable values
├── modules/
│   ├── eks/         # EKS cluster module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── jenkins/     # Jenkins module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── sonarqube/   # SonarQube module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── nexus/       # Nexus module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── jenkinsfile      # For CI/CD pipeline

Setup Instructions
1. Configure AWS Credentials
Ensure your AWS credentials are configured:
bashCopyaws configure

2. Update terraform.tfvars
Edit the terraform.tfvars file to specify your AWS account details and infrastructure preferences:
hclCopy# Replace these values with your actual information
vpc_id     = "vpc-0123456789abcdef0"
subnet_ids = ["subnet-0123456789abcdef1", "subnet-0123456789abcdef2", "subnet-0123456789abcdef3"]
Also update the admin passwords for each service to secure values.

3. Initialize Terraform
bashCopyterraform init

4. Plan the Deployment
bashCopyterraform plan
Review the plan to ensure it will create the expected resources.

5. Apply the Configuration
bashCopyterraform apply
Type yes when prompted to create the infrastructure.

6. Configure kubectl
After the EKS cluster is created, configure kubectl to use the new cluster:
bashCopyaws eks update-kubeconfig --name devops-cluster --region us-west-2
Accessing the Services
After deployment, use the following commands to get the URLs for each service:
bashCopy# Get Jenkins URL
kubectl get svc -n jenkins

# Get SonarQube URL
kubectl get svc -n sonarqube

# Get Nexus URL
kubectl get svc -n nexus
Alternatively, you can check the Terraform outputs:
bashCopyterraform output
CI/CD Pipeline Setup

Access the Jenkins instance using the URL from the outputs
Log in with the admin credentials specified in terraform.tfvars
Create a new pipeline job
Configure the pipeline to use the Jenkinsfile from this repository
Set up credentials in Jenkins for:

Nexus Repository Manager
SonarQube
Kubernetes (kubeconfig)



Cleanup
To destroy all created resources:
bashCopyterraform destroy
Type yes when prompted.
Security Considerations

In a production environment, consider using AWS Secrets Manager or HashiCorp Vault for managing credentials
The terraform.tfvars file should not be committed to version control as it contains sensitive information
Review and restrict the security groups and network policies for each service
Consider enabling IAM roles for service accounts (IRSA) for more granular permissions

Customization
You can customize this infrastructure by modifying:

terraform.tfvars for basic configuration
Module variables in main.tf for more specific customization
Individual module files for detailed changes to each component

Contributing

Fork the repository
Create a feature branch
Commit your changes
Push to the branch
Create a new Pull Request
