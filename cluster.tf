#############################
# Criação de security group #
#############################

resource "aws_security_group" "my-sg" {
  vpc_id = aws_vpc.new-vpc.id
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    Name = "${var.prefix}-sg"
  }
}

###################
# Criação de role #
###################

resource "aws_iam_role" "cluster" {
  name               = "${var.prefix}-${var.cluster_name}-role"
  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
        {
           "Effect": "Allow",
           "Principal": {
                "Service": "eks.amazonaws.com"
           },
           "Action": "sts:AssumeRole"
        }  
    ]
  }
  POLICY
}

################################
# Adicionando politicas a role #
################################

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSVPCResourceController" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

##################################
# Criação de logs para o cluster #
##################################

resource "aws_cloudwatch_log_group" "log" {
  name              = "/aws/eks/${var.prefix}-${var.cluster_name}/cluster"
  retention_in_days = var.retention_days
}

######################
# Criação do cluster #
######################

resource "aws_eks_cluster" "cluster" {
  name                      = "${var.prefix}-${var.cluster_name}"
  role_arn                  = aws_iam_role.cluster.arn
  enabled_cluster_log_types = ["api", "audit"]
  vpc_config {
    subnet_ids         = aws_subnet.subnets[*].id
    security_group_ids = [aws_security_group.my-sg.id]
  }
  depends_on = [
    aws_cloudwatch_log_group.log,
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-AmazonEKSVPCResourceController
  ]
}