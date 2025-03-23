
variable "namespace" {

  description = "Kubernetes namespace for Nexus deployment"

  type        = string

  default     = "nexus"

}



variable "storage_class_name" {

  description = "Storage class name for Nexus PVC"

  type        = string

  default     = "gp2"

}

variable "nexus_admin_password" {
  description = "Admin password for Nexus repository manager"
  type        = string
  sensitive   = true
}
