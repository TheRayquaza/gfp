resource "aws_eks_cluster" "gfp-cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.gfp-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.gfp-cluster.id]
    subnet_ids         = aws_subnet.gfp-cluster[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.gfp-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.gfp-cluster-AmazonEKSVPCResourceController,
  ]
}
