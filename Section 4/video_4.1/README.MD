
1. Install the Digital Ocean Vagrant plugin:
```
vagrant plugin install vagrant-digitalocean
```
2. Provision the Jenkins Master machine on Digital Ocean
```
cd jenkins_machines
vagrant up --provider=digital_ocean
```
3. Setup jenkins

  3.1 access the machine via ssh

    ```
    vagrant ssh
    ```

  3.2 copy the initial Admin Password

    ```
    cat /var/lib/jenkins/secrets/initialAdminPassword
    ```

  3.3 access http://<droplet-ip>:8080

  3.4 Paste the password copied, click on continue

  3.5 Click on "Install suggested plugins"

  3.6 Create an admin account
