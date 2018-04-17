sudo chown -R jenkins.jenkins ${1}/.ssh/

if [ -f "${1}/.ssh/id_rsa*" ]; then
    sudo chmod 400 ${1}/.ssh/id_rsa*
fi

if [ -f "${1}/.ssh/authorized_keys" ]; then
  sudo chmod 400 ${1}/.ssh/authorized_keys
fi
