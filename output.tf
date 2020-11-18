# All new instances which are running.
data "aws_instances" "target" {
  instance_tags = {
    Name = "${upper(var.environment)}-BASTION-EC2-ASG"
  }
  instance_state_names = ["running"]
}

data "aws_instance" "target" {
  count       = length(data.aws_instances.target.ids)
  instance_id = data.aws_instances.target.ids[count.index]
}

output "public_ips" {
  value = data.aws_instance.target.*.public_ip
}