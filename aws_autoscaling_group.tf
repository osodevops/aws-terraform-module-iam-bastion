resource "aws_launch_configuration" "bastion_launch_config" {
  name_prefix                 = "${upper(var.environment)}-BASTION-ASG-"
  image_id                    = data.aws_ami.bastion_ami_amazon.image_id
  instance_type               = var.ec2_instance_type
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.name
  security_groups             = [aws_security_group.bastion_sg.id]
  user_data                   = data.template_file.script.rendered
  associate_public_ip_address = true

  ebs_block_device {
    encrypted   = true
    volume_size = "40"
    device_name = "/dev/sdb"
    volume_type = "standard"
  }

  root_block_device {
    encrypted = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion_asg" {
  name                 = "${upper(var.environment)}-BASTION-ASG"
  launch_configuration = aws_launch_configuration.bastion_launch_config.name
  vpc_zone_identifier  = var.subnet_ids
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  desired_capacity     = var.asg_desired_capacity

  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
      key                 = "Name"
      value               = "${upper(var.environment)}-BASTION-EC2-ASG"
      propagate_at_launch = true
    },
  ]
}
