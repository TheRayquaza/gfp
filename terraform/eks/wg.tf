resource "aws_iam_role" "gfp-node" {
  name = "terraform-eks-gfp-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "gfp-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.gfp-node.name
}

resource "aws_iam_role_policy_attachment" "gfp-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.gfp-node.name
}

resource "aws_iam_role_policy_attachment" "gfp-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.gfp-node.name
}

resource "aws_eks_node_group" "gfp" {
  cluster_name    = aws_eks_cluster.gfp-cluster.name
  node_group_name = "gfp"
  node_role_arn   = aws_iam_role.gfp-node.arn
  subnet_ids      = aws_subnet.gfp-cluster-workers[*].id
  instance_types  = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = "my-key"
    source_security_group_ids = [aws_security_group.eks_ssh_access.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.gfp-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.gfp-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.gfp-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
