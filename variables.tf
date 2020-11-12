variable "asg_desired_capacity" {
  description = "Default number of bastion instances."
  type = number
  default = 1
}

variable "asg_min_size" {
  description = "Min number of bastion instances."
  type = number
  default = 1
}

variable "asg_max_size" {
  description = "Max number of bastion instances."
  type = number
  default = 1
}

variable "ec2_instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t3a.micro"
}

variable "environment" {
  description = "Environment descriptor."
  type = string
}

variable "enable_ssh_group" {
  description = "Enable ssh group access using dynamic ssh keys."
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "A list of Subnet IDs - should be public."
  type        = list(string)
}

variable "allowed_ips" {
  description = "Allow this list of IPs through the security group."
  type        = list(string)
}

variable "ssh_users" {
  description = "List of users to add the ssh users group, (optional)"
  type        = list
  default     = ["sample"]
}

variable "ssh_name" {
  type        = string
  description = "The name of the ssh group objects."
  default     = "ssh"
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy bastion."
  type        = string
}

variable "common_tags" {
  type        = map(string)
  description = "Implements the common tags scheme"
}

