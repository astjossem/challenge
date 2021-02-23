data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "instance_sg" {
  description = "Ingress and egress for terraform provisioned instancse"
  name        = "ec2-sg"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "ssh_ingress" {
  count             = var.ssh_access ? 1 : 0
  security_group_id = aws_security_group.instance_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "SSH from everywhere!"
  from_port         = 22
  protocol          = "tcp"
  self              = false
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "internal_ingress" {
  security_group_id = aws_security_group.instance_sg.id
  cidr_blocks       = []
  description       = "Http inside netowork"
  from_port         = 80
  protocol          = "tcp"
  self              = true
  to_port           = 80
  type              = "ingress"
}

resource "aws_security_group_rule" "egress_internal" {
  security_group_id = aws_security_group.instance_sg.id
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  self              = true
}

resource "aws_security_group_rule" "egress_external" {
  security_group_id = aws_security_group.instance_sg.id
  type              = "egress"
  cidr_blocks       = [ "0.0.0.0/0" ]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  self              = false
}