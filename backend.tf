terraform {
  backend "s3" {
    bucket = "terraform-state-lock-aws-bucket"
    key    = "terraform.state"
    region = "us-east-1"
    profile = "admin"
    use_lockfile = true
  }
}
