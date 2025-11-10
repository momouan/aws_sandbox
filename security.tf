resource "aws_security_group" "k8s" {
  name        = "${var.project}-sg"
  description = "K8s sandbox SG"
  vpc_id      = aws_vpc.sbx.id

  # SSH from your current public IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.resolved_ssh_cidr]
    description = "SSH"
  }

  # Kubernetes API (optional during bootstrap)
  dynamic "ingress" {
    for_each = var.allow_api_6443 ? [1] : []
    content {
      from_port   = 6443
      to_port     = 6443
      protocol    = "tcp"
      cidr_blocks = [local.resolved_ssh_cidr]
      description = "K8s API"
    }
  }

  # NodePort range (optional for tests)
  dynamic "ingress" {
    for_each = var.allow_nodeport ? [1] : []
    content {
      from_port   = 30000
      to_port     = 32767
      protocol    = "tcp"
      cidr_blocks = [local.resolved_ssh_cidr]
      description = "NodePorts (testing)"
    }
  }

  # Intra-cluster any/any inside the SG
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "intra-cluster"
  }

  # Egress to Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project}-sg" }
}
