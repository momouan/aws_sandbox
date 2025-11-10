output "vpc_id" {
  value = aws_vpc.sbx.id
}
output "public_subnet_id" {
  value = aws_subnet.public.id
}
output "public_subnet_cidr" {
  value = aws_subnet.public.cidr_block
}
output "security_group_id" {
  value = aws_security_group.k8s.id
}
output "ssh_cidr_effective" {
  value = local.resolved_ssh_cidr
}
output "leader_public_ip" {
  value = aws_instance.leader.public_ip
}
output "worker_public_ips" {
  value = [for w in aws_instance.worker : w.public_ip]
}
output "leader_private_ip" {
  value = aws_instance.leader.private_ip
}
output "worker_private_ips" {
  value = [for w in aws_instance.worker : w.private_ip]
}

