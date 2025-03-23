# modules/jenkins/main.tf

# Create namespace for Jenkins
resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.namespace
  }
}

# Create a persistent volume claim for Jenkins
resource "kubernetes_persistent_volume_claim" "jenkins_pvc" {
  metadata {
    name      = "jenkins-pvc"
    namespace = kubernetes_namespace.jenkins.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
    storage_class_name = var.storage_class_name
  }
}

# Deploy Jenkins using Helm
resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = kubernetes_namespace.jenkins.metadata[0].name
  version    = "4.3.0"  # Specify the chart version

  values = [
    <<-EOT
    controller:
      adminPassword: "${var.jenkins_admin_password}"
      serviceType: LoadBalancer
      persistentVolume:
        existingClaim: ${kubernetes_persistent_volume_claim.jenkins_pvc.metadata[0].name}
      installPlugins:
        - kubernetes:3734.v562b_b_a_627ea_c
        - workflow-aggregator:590.v6a_d052e5a_a_b_5
        - git:4.12.1
        - configuration-as-code:1569.vb_72405b_80249
        - sonar:2.15
        - nexus-artifact-uploader:2.14
        - pipeline-utility-steps:2.13.0
    agent:
      enabled: true
      resources:
        requests:
          cpu: "500m"
          memory: "1Gi"
        limits:
          cpu: "1"
          memory: "2Gi"
    EOT
  ]

  depends_on = [
    kubernetes_namespace.jenkins,
    kubernetes_persistent_volume_claim.jenkins_pvc
  ]
}

# Get Jenkins URL
data "kubernetes_service" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = kubernetes_namespace.jenkins.metadata[0].name
  }
  depends_on = [helm_release.jenkins]
}