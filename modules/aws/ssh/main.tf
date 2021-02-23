resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key" {
  filename        = "${path.root}/private-key"
  content         = tls_private_key.private_key.private_key_pem
  file_permission = "0600"
}

resource "aws_key_pair" "generated_key_pair" {
  key_name    = "ssh_key_pair"
  public_key  = tls_private_key.private_key.public_key_openssh
}