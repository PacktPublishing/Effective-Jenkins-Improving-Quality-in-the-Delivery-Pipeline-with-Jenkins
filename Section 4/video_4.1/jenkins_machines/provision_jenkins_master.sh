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

# Add jenkins GPG Key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo 'deb https://pkg.jenkins.io/debian-stable binary/' > /etc/apt/sources.list.d/jenkins.list

export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get -qy update

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    docker-ce \
    default-jdk \
    jenkins

# Add Machines to known_hosts
mkdir -p ${JENKINS_HOME}/.ssh
sudo chown -R jenkins.jenkins ${JENKINS_HOME}/.ssh
# sudo chmod 600 ${JENKINS_HOME}/.ssh/id_rsa*
