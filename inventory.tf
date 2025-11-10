locals {
  ssh_key_path = "~/.ssh/sandbox"
  ssh_user     = "ubuntu"
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"
  content = templatefile("${path.module}/templates/inventory.tpl", {
    leader_private_ip = aws_instance.leader.private_ip
    leader_public_ip  = aws_instance.leader.public_ip
    workers           = [for w in aws_instance.worker : { priv = w.private_ip, pub = w.public_ip }]
    ssh_user          = local.ssh_user
    ssh_key_path      = local.ssh_key_path
  })
}
