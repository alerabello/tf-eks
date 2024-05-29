module "kubernetes-dashboard" {
# Dependencia do modulo EKS para criar a instancia EC2.
  depends_on = [ module.eks ]

  source = "cookielab/dashboard/kubernetes"
  version = "0.11.0"

  kubernetes_namespace_create = true
  kubernetes_dashboard_csrf = "!@#$%159!@#$"

}