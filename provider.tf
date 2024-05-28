provider "aws" {
  region = "us-west-2"
  profile = "${{ secrets.AWS_PROFILE }}"
}

provider "kubernetes" {
  config_path = "${{ secrets.KUBE_CONFIG }}"
  host   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]  
  }   
}

provider "helm" {
    kubernetes {
        config_path = "${{ secrets.KUBE_CONFIG }}"
        host   = module.eks.cluster_endpoint
        cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
        
        exec {
            api_version = "client.authentication.k8s.io/v1alpha1"
            args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
        }
    }  
}

provider "kubectl" {
    host   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    load_config_file = false
    token = data.aws_eks_cluster_auth.this.token
}