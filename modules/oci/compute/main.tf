resource "oci_core_instance" "instance" {
  count               = var.instance_count

  availability_domain = var.instance_availability_domain
  compartment_id      = var.compartment_id
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id = var.subnet_id
  }

  metadata = {
    ssh_authorized_keys = file("${path.module}/../../../examples/oci/${var.ssh_public_key}")
    user_data  = base64encode(file("${path.module}/cloud-init.sh"))
  }

  source_details {
    source_id = var.image_ocid
    source_type = "image"
  }
}