data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "ec2_compute" {
  count                   = var.instance_count
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.micro"
  key_name                = var.ssh_access ? var.key_name : ""
  user_data               = templatefile("${path.module}/cloud-init.sh", {SSH=local.ssh_script })
  vpc_security_group_ids  = var.security_group_ids
}

resource "null_resource" "wait_for_cloud_init" {
  count = var.ssh_access ? var.instance_count : 0
  provisioner "remote-exec" {
    connection {
      host = aws_instance.ec2_compute[count.index].public_ip
      user = "ubuntu"
      agent = false
      private_key = var.private_key_pem
    }
    inline = [ 
      "echo 'Waiting for cloud-init to complete...'",  
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'"
    ]
  }
}