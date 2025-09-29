

variable "location" {
  type        = string
  default     = "East US"
  description = "Location"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for AKS"
  default     = "EbasResourceGroup"
}

variable "aks_cluster_name" {
  type        = string
  description = "AKS cluster name"
  default     = "ebascluster"
}

variable "node_count" {
  type        = number
  default     = 2
  description = "Number of nodes in the default node pool"

}

variable "vm_size" {
  type        = string
  description = "VM size for AKS nodes"
  default     = "standard_a2_v2"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for AKS"
  default = "ebas-aks"
}
