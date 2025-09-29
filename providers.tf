provider "azurerm" {
  features {}
  subscription_id = "6b6f9f6b-65ad-4554-b155-50a30e55f945"
  resource_provider_registrations = "none"
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_admin_config.0.host
  token                  = data.azurerm_kubernetes_cluster_auth.aks.kube_admin_token
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config.0.cluster_ca_certificate)
}