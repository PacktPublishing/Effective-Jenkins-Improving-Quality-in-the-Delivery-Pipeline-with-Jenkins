#!/bin/bash
# add username
sudo adduser --disabled-password --gecos "" jenkins
# Add the jenkins to sudo group
sudo usermod -aG sudo jenkins
# Add deploy group
sudo groupadd deploy
# Add jenkins to deploy group
sudo usermod -aG deploy jenkins

# set password
echo "jenkins:jenkins" | chpasswd

sudo echo "jenkins ALL=(ALL:ALL) ALL" >> /etc/sudoers
sudo echo "%deploy ALL=(ALL) ALL" >> /etc/sudoers

# Install java jdk8
sudo apt-get update
sudo apt-get install -y default-jdk

mkdir -p /home/jenkins/.ssh
sudo chown -R jenkins.jenkins /home/jenkins/.ssh

# Prepare folder to deploy the app
sudo chgrp deploy /opt/
sudo chmod -R g+rwx /opt/
sudo mkdir -p /opt/app
chown -R jenkins.jenkins /opt/app

# Install MySQL
sudo apt-get update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y vim curl python-software-properties
sudo apt-get update
sudo apt-get -y install mysql-server
sed -i "s/^bind-address/#bind-address/" /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES; SET GLOBAL max_connect_errors=10000;"
mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS user_mgt"
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON user_mgt.* TO 'springuser'@'%' IDENTIFIED BY 'xXuVBAnXsRm3R2eT' WITH GRANT OPTION; FLUSH PRIVILEGES; SET GLOBAL max_connect_errors=10000;"
sudo /etc/init.d/mysql restart

sudo systemctl daemon-reload

# sudo reboot
