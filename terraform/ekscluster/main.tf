resource "aws_eks_cluster" "mycluster" {
  name     = "mycluster"
  role_arn = var.eksiamrolearn
  version = "1.19"
  vpc_config {
    subnet_ids = [var.private_subnet1,var.private_subnet2]
    endpoint_private_access = true
    endpoint_public_access = true
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.

}

resource "aws_eks_node_group" "mynodegroup" {
  cluster_name    = aws_eks_cluster.mycluster.name
  node_group_name = "mynodegroup"
  node_role_arn   = var.eksnodegrouprolearn
  subnet_ids      = [var.private_subnet1,var.private_subnet2]
  instance_types = ["t3.medium"]
  remote_access {
    ec2_ssh_key = "kiran"
  }
  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  
}
