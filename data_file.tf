data "template_file" "script" {
  template = file("${path.module}/scripts/user_data.sh")

  vars = {
    ssh_users = join(" ",var.ssh_users)
  }
}