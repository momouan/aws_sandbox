data "http" "myip" {
  url = "https://checkip.amazonaws.com"
}

locals {
  resolved_ssh_cidr = var.ssh_cidr != "" ? var.ssh_cidr : "${chomp(data.http.myip.response_body)}/32"
}