output "cluster_ca_certificate_authority_data" {
    description = "base64 encoded PEM certificate of the CA that signed the EKS cluster certificate"
    value = try(aws_eks_cluster.this[0].certificate_authority[0].data, null)
}