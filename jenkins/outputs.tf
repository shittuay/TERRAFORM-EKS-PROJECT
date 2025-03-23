# modules/sonarqube/main.tf

# Create namespace for SonarQube
resource "kubernetes_namespace" "sonarqube" {
  metadata {
    name = var.namespace
  }
}

# Create a persistent volume claim for SonarQube
resource "kubernetes_persistent_volume_claim" "sonarqube_pvc" {
  metadata {
    name      = "sonarqube-pvc"
    namespace = kubernetes_namespace.sonarqube.metadata[0].name
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

# Deploy SonarQube using Helm
resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart      = "sonarqube"
  namespace  = kubernetes_namespace.sonarqube.metadata[0].name
  version    = "10.0.0"  # Specify the chart version

  values = [
    <<-EOT
    service:
      type: LoadBalancer
    persistence:
      enabled: true
      existingClaim: ${kubernetes_persistent_volume_claim.sonarqube_pvc.metadata[0].name}
    sonarqubeConfig:
      sonarProperties: |
        sonar.forceAuthentication=true
    adminPassword: ${var.sonarqube_admin_password}
    postgresql:
      enabled: true
      persistence:
        enabled: true
        storageClass: "${var.storage_class_name}"
    EOT
  ]

  depends_on = [
    kubernetes_namespace.sonarqube,
    kubernetes_persistent_volume_claim.sonarqube_pvc
  ]
}

# Get SonarQube URL
data "kubernetes_service" "sonarqube" {
  metadata {
    name      = "sonarqube-sonarqube"
    namespace = kubernetes_namespace.sonarqube.metadata[0].name
  }
  depends_on = [helm_release.sonarqube]
}