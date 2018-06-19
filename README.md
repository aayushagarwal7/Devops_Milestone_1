# Devops_Milestone1
CSC 519 - Project Milestone 1 Repo

### Team Details:

| Name   | Unity ID |
| ------------- | ------------ |
| Aayush Agarwal | asagarwa |
| Sambhav Jain | sjain11 |
| Darshan Patel | dpatel12 |
| Ameya Prabhu | aprabhu2 |

### Prerequisites:

- Enter all environment variables
- Make sure source laptop has Pip and Boto3 installed

### Steps to run the project

- Set ENV Variables on MAC terminal - Set access key, secret key in this format:

```
export AWS_ACCESS_KEY_ID="xyz" 
export AWS_SECRET_ACCESS_KEY="xyz"
export MONGO_PORT="3002"
export MONGO_IP="127.0.0.1"
export MONGO_USER="admin"
export MONGO_PASSWORD="abcd"
export MAIL_USER="ur email"
export MAIL_PASSWORD="ur pass"
export MAIL_SMTP="smtp.gmail.com"
export git_username="username"
export git_token="token"
```

- Install the following:
1. Install Ansible and Pip
```
sudo pip install boto3
sudo pip install boto --upgrade
```
Clone this repo and run:

```
ansible-playbook itrust/itrust.yml
```

### Issues faced for creation of AWS Instance (sjain11)

- Env variables need to be tranferred to targetted AWS Instance. We used the ansible blockinfile module to transfer them.
- We need to pull latest created AWS Instance public IP. This IP needs to be added inside the inventory file or in-memory inventory if used.
- Need to add rules in security group to allow all http, tcp, ssh connections.
- Need to wait for SSH to come up for AWS instance or else the next ansible script fails.
- To avoid hassle of known hosts entry, it is advised to use _key_host_checking=False_ to avoid build failure in Jenkins.

### Issues faced for Jenkins Provisioning, Setup and Configuration (asagrwa, sjain11)

- It was problematic to remove the setup wizard and avoid/skip any steps that hinder installation.
- We had to make sure Jenkins port was available on port 8080.
- We also had to install many plugins for postbuilds to work. Some examples were postbuildscript, postbuild-task.
- We also had to install various python sub modules like python-software properties, setuptools.
- We also had AWS instances failing from jenkins during post-build. As a solution we generated ssh keygen inside Jenkins VM so that it can connect to AWS instances launched through it.
- When installing the jenkins plugins, jenkins_plugin module of ansible was not allowing us to pass jenkins password in the params field. Initially we used ansible version 2.4.3.0 which was giving this error. It allows passing password in the 2.4.0.0 version. So we used that ansible version to skip this error. Then it was fixed by removing the jenkins password from the params and passing it separately to the jenkins_plugin module.

### Issues faced for Build, Provision, Deploy Itrust2v2 (asagarwa, sjain11(little debugging))

- It was initially proving to be difficult to install java8 and mysql using ansible but later after reading articles, I discovered how to install it in a non interactive fashion.
- First i tried running itrust on a Vagrant ubuntu VM manually. On vagrant the database connections with MySQL were working fine with no password being set for MySQL but after writing the script and deploying it on ansible, putting no password did not allow the test job for iTrust to pass
- After putting in a password for mysql, the test job ran fine but then I was unable to login through the browser.
- To overcome this deadlock, I found a solution to enter skip-grant-table in config file. Doing this itrust is able to connect to mysql with no password.
- We were not able to fire the final few commands that run itrust. We solved by using the _&_ operator that shell provides. To fire this command on the Itrust VM we had to use the shell module as it was causing error with all other modules. 

### Issues faced for Build, Provision, Deploy Checkbox.io (aprabhu2, sjain11, dpatel12)

- For checkbox VM, we were having problems connecting to Nginx. We found the solution in terms of copying conf and default files for nginx in /etc/nginx.. We also had to change paths inside those files and make sure public_html has correct access rights.
- Transferring environment variables from local host to the VM for checkbox deployment is troublesome. There is 2 layer of transfers. 
- We had to install lot of additional plugins for the post build tasks. This takes time with respect to localizing which plugins to install and how to install them without impacting the build. 
- To trigger the build, ansible does not have any module. This has to be done via Jenkins CLI. Having an ansible module for triggering builds would go a long way in making lives of developers easier. 
- Known hosts files had to be bypassed. This is a security risk. 

### Screencast: (asagarwa)

Please find the link to screencast [here](https://youtu.be/eW6idXWKe74)
