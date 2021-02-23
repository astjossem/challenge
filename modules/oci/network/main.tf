resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartment_id
  cidr_blocks    = var.cidr_blocks
}

resource "oci_core_subnet" "subnet" {
  cidr_block      = var.cidr_blocks[0]
  compartment_id  = var.compartment_id
  vcn_id          = oci_core_vcn.vcn.id
}