
output "endpoint" {
  value = aws_eks_cluster.mycluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.mycluster.certificate_authority[0].data
}