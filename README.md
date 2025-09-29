For a Kubernetes cluster (AKS) deployment in azure with terraform there are 4 main files for develoment:

main.tf
````
resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  dns_prefix = var.dns_prefix
}
````
outputs.tf
````
output "aks_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_id" {
  description = "Resource ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_kube_config_raw" {
  description = "Raw kubeconfig content (sensitive)"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

````

providers.tf (modified without my azure id)
````
provider "azurerm" {
  features {}
  subscription_id = "Your azure id"
  resource_provider_registrations = "none"
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_admin_config.0.host
  token                  = data.azurerm_kubernetes_cluster_auth.aks.kube_admin_token
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config.0.cluster_ca_certificate)
}
````
variables.tf
````


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

````
after the configuration with the commands 
````
terraform init
````
````
terraform plan
````
````
terraform apply
````
with those commands the deployment will start, after deployment in our azure account well find 2 main files related to the cluster 
<img width="1523" height="699" alt="image" src="https://github.com/user-attachments/assets/cc85ff6f-ff9c-4036-a5d4-b86b280ce222" />
<img width="1849" height="737" alt="image" src="https://github.com/user-attachments/assets/63194f97-5d1a-455c-bf7c-b5e7cdd96547" />


