data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "leader" {
  ami                         = data.aws_ami.ubuntu_2204.id
  instance_type               = var.instance_type_leader
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.k8s.id]
  associate_public_ip_address = true
  tags                        = { Name = "${var.project}-leader", Role = "leader", Kubernetes = "true" }
}

resource "aws_instance" "worker" {
  count                       = var.worker_count
  ami                         = data.aws_ami.ubuntu_2204.id
  instance_type               = var.instance_type_worker
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.k8s.id]
  associate_public_ip_address = true
  tags                        = { Name = "${var.project}-worker-${count.index + 1}", Role = "worker", Kubernetes = "true" }
}
