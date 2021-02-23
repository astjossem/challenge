variable "region" {
  description = "AWS region in which resources will be deployed to"
  type        = string
}

variable "instance_count" {
  description = "Number of compute instances (VMs) to create"
  type        = number
}

variable "ssh_access" {
  description = "Disable ssh access to vms"
  type        = bool
}