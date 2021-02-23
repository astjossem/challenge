output "ssh_key_name" {
  value = aws_key_pair.generated_key_pair.key_name  
}

output "private_key_pem" {
  value = tls_private_key.private_key.private_key_pem
}