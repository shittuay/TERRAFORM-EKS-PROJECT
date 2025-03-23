# modules/nexus/main.tf

# Create namespace for Nexus
resource "kubernetes_namespace" "nexus" {
  metadata {
    name = var.namespace
  }
}

# Create a persistent volume claim for Nexus
resource "kubernetes_persistent_volume_claim" "nexus_pvc" {
  metadata {
    name      = "nexus-pvc"
    namespace = kubernetes_namespace.nexus.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "20Gi"
      }
    }
    storage_class_name = var.storage_class_name
  }
}

# Deploy Nexus using Helm
resource "helm_release" "nexus" {
  name       = "nexus"
  repository = "https://sonatype.github.io/helm3-charts/"
  chart      = "nexus-repository-manager"
  namespace  = kubernetes_namespace.nexus.metadata[0].name
  version    = "42.0.0"  # Specify the chart version

  values = [
    <<-EOT
    nexus:
      docker:
        enabled: true
        registries:
          - host: docker.registry
            port: 5000
      resources:
        requests:
          cpu: "500m"
          memory: "2Gi"
        limits:
          cpu: "1"
          memory: "4Gi"
    persistence:
      enabled: true
      existingClaim: ${kubernetes_persistent_volume_claim.nexus_pvc.metadata[0].name}
    service:
      type: LoadBalancer
    EOT
  ]

  depends_on = [
    kubernetes_namespace.nexus,
    kubernetes_persistent_volume_claim.nexus_pvc
  ]
}

# Get Nexus URL
data "kubernetes_service" "nexus" {
  metadata {
    name      = "nexus-nexus-repository-manager"
    namespace = kubernetes_namespace.nexus.metadata[0].name
  }
  depends_on = [helm_release.nexus]
}