provider "oci" {
  tenancy_ocid = var.tenancy_ocid
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

module "network" {
  source = "../../modules/oci/network"

  compartment_id  = var.compartment_id
}

module "compute" {
  source = "../../modules/oci/compute"

  instance_count                = var.instance_count
  instance_availability_domain  = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id                = var.compartment_id
  instance_shape                = var.instance_shape
  subnet_id                     = module.network.subnet_id
  ssh_public_key                = var.ssh_public_key
}