#!/bin/bash
JENKINS_HOME=/var/lib/jenkins

# add username
sudo adduser --home ${JENKINS_HOME} --disabled-password --gecos "" jenkins
# Add the jenkins to sudo group
sudo usermod -aG sudo jenkins
#Add a group called docker
sudo groupadd docker
#Add the jenkins user to this group
sudo usermod -aG docker jenkins

# set password
echo "jenkins:jenkins" | chpasswd

###### Docker installation
# remove old instalation of docker
sudo apt-get remove -y docker docker-engine docker-ce docker.io

# Add docker GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y\
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

sudo apt-get install -y docker-ce

###### Jenkins installation

# Add jenkins GPG Key
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo 'deb https://pkg.jenkins.io/debian-stable binary/' > /etc/apt/sources.list.d/jenkins.list

sudo apt-get update
sudo apt-get install -y jenkins
sudo apt-get install -y default-jdk

# Add Machines to known_hosts
mkdir -p ${JENKINS_HOME}/.ssh
sudo chown -R jenkins.jenkins ${JENKINS_HOME}/.ssh
sudo chmod 600 ${JENKINS_HOME}/.ssh/id_rsa*
ssh-keyscan -H 192.168.50.5 >> ${JENKINS_HOME}/.ssh/known_hosts
ssh-keyscan -H 192.168.50.6 >> ${JENKINS_HOME}/.ssh/known_hosts
