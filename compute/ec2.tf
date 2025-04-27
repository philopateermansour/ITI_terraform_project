resource "aws_instance" "bastion" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_id
  security_groups = [aws_security_group.bastion_sg.id]
  key_name        = aws_key_pair.sshkeypair.key_name
  
    tags = {
        Name = "Bastion Instance"
    }
  provisioner "local-exec" {
    command = "echo ${self.public_ip}"
  }
}

resource "aws_instance" "application" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_id
  security_groups = [aws_security_group.application_sg.id]
  key_name        = aws_key_pair.sshkeypair.key_name

    tags = {
        Name = "Application Instance"
    }
}