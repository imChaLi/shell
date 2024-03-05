#!/bin/bash

# Enable PermitRootLogin and PasswordAuthentication in sshd_config
sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;

# Restart the SSH service
sudo service sshd restart

echo "SSH configuration updated and service restarted."
