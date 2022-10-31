# Terraform AWS Provider Block
provider "aws" {
  region = var.aws_region
}

# Datasource: EKS Cluster Authentication
data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_id
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host = var.cluster_endpoint 
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  token = data.aws_eks_cluster_auth.cluster.token
}

# HELM Provider
provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}