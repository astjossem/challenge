variable "tenancy_ocid" {
  description = "Tenany OCID"
  type        = string
}

variable "instance_count" {
  description = "Number of compute instances (VMs) to create"
  type        = number
}

variable "compartment_id" {
  description = "ID of compartment resources will be deployed into"
  type        = string
}

variable "instance_shape" {
  description = "Instance shape - representing CPUs, mem etc."
  type        = string
}

variable "ssh_public_key" {
  description = "Public key for ssh access"
  type        = string
}