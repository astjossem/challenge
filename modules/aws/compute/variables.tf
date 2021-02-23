locals {
  ssh_script = var.ssh_access ? "" : "sudo ufw enable -y; sudo systemctl disable ssh; sudo ufw deny ssh"
}

variable "instance_count" {
  description = "Number of compute instances (VMs) to create"
  type        = number
}

variable "key_name" {
  description = "Name of AWS SSH key pair"
  type        = string
}

variable "private_key_pem" {
  description = "Private ssh key data"
  type        = string
}

variable "security_group_ids" {
  description = "ID of AWS security group"
  type        = list(string)
}

variable "ssh_access" {
  description = "Access to ssh allowed"
  type        = bool
}