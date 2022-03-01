#bash <(curl -Ls https://raw.githubusercontent.com/ichali/shell/main/root-login.sh)
echo root:ckw5282977?CKWW |sudo chpasswd root
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
sudo reboot
