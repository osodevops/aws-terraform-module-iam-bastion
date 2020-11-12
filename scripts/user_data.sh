#!/usr/bin/env bash

# Start logging
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/var/log/user-data-log.log 2>&1

echo ${ssh_users}

declare -A USERKEY

declare -A SUDOUSER

# Iterate through all users (based on the associative array USERKEY)
for user in ${ssh_users} ; do
  #if user is email address
  if [[ "$user" == *"@"* ]]; then
    #strip out email
    user=$(echo $user | cut -f 1 -d '@')
  fi

  # Add the user and create default home directory for ssh
  adduser -m -d /home/$user $user

  # Give read-only access to log files by adding the user to adm group
  # Other groups that you may want to add are apache, nginx, mysql etc. for their log files
  usermod -a -G adm $user

  # Give sudo access by adding the user to sudo group
  usermod -a -G wheel $user
  # Allow passwordless sudo
  echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users

  # Add the user's auth key to allow ssh access
  mkdir /home/$user/.ssh

  # Change ownership and access modes for the new directory/file
  chown -R $user:$user /home/$user/.ssh
  chmod -R go-rx /home/$user/.ssh
done