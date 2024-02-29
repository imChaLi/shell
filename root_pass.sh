#!/bin/bash

# 安装sudo
apt install sudo -y

# 切换到root用户
sudo su

# 进入root用户的家目录
cd

# 修改sshd_config文件，允许root登录和密码认证
sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# 设置root用户的密码
echo root:--- | sudo chpasswd

# 重启SSH服务
sudo service ssh restart
