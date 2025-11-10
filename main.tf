data "aws_caller_identity" "me" {}
data "aws_region" "current" {}

output "whoami" {
  value = {
    account = data.aws_caller_identity.me.account_id
    arn     = data.aws_caller_identity.me.arn
    region  = data.aws_region.current.name
  }
}
