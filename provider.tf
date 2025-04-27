provider "aws" {
  region = var.aws_region
  profile = "admin"
}

resource "aws_ses_email_identity" "email_identity" {
  email = var.email
}