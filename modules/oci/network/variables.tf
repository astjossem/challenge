variable "compartment_id" {
  description = "ID of compartment resources will be deployed into"
  type        = string
}

variable "cidr_blocks" {
  description = "CIDR block range for new network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}