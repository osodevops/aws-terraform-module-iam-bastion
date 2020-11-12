# AWS Terraform Module IAM Bastion


A bastion controlled by dynamic ssh generated from IAM. Short lived keys and pre-provisioned users via userdata.


EC2 Instance Connect feature is enabled on an instance, the SSH daemon (sshd) on that instance is configured with a custom AuthorizedKeysCommand script. This script updates AuthorizedKeysCommand to read SSH public keys from instance metadata during the SSH authentication process, and connects you to the instance.

The SSH public keys are only available for one-time use for 60 seconds in the instance metadata. To connect to the instance successfully, you must connect using SSH within this time window. Because the keys expire, there is no need to track or manage these keys directly, as you did previously.


```bash
 ssh-keygen -t rsa -b 4096 -C "sion" -f sion_id_rsa

aws ec2-instance-connect send-ssh-public-key --instance-id <<instance-id>> --availability-zone eu-west-2c --instance-os-user ec2-user --region eu-west-2 --ssh-public-key file://sion_id_rsa

ssh -i sion_id_rsa ec2-user@e<<instance-ip>>
```
