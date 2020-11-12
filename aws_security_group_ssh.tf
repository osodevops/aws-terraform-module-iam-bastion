resource "aws_security_group" "bastion_sg" {
  description = "Security group that allows all ssh traffic from allow ips"
  name        = "${upper(var.environment)}-BASTION-PUB-SG"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${upper(var.environment)}-BASTION-PUB-SG"
  }
}

resource "aws_security_group_rule" "bastion_sg_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ips
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}
