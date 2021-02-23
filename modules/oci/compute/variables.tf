variable "instance_count" {
  description = "Number of compute instances (VMs) to create"
  type        = number
}

variable "instance_availability_domain" {
  description = "Availability domain the instances will be provisioned in"
  type        = string
}

variable "compartment_id" {
  description = "ID of compartment resources will be deployed into"
  type        = string
}

variable "instance_shape" {
  description = "Instance shape - representing CPUs, mem etc."
  type        = string
}

variable "subnet_id" {
  description = "Subnet id"
  type        = string
}

variable "image_ocid" {
  description = "ID value of OS image"
  type        = string
  default     = "ocid1.image.oc1.phx.aaaaaaaavhykwhe4bhsoa25kv2sbjixy3a3kqud33wvfjnim7yuhbvwbb4gq"
}

variable "ssh_public_key" {
  description = "Public key for ssh access"
  type        = string
}