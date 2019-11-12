# Supporting repo for Ansible for DevOps - Jeff Geerling
This repo is intended to provide support scripts and demonstrations for the [Ansible for DevOps](https://leanpub.com/ansible-for-devops) book, provided by [LeanPub.com](https://leanpub.com/ansible-for-devops) (as of September 2019).

Chapters 1 and 2 are available for FREE on [LeanPub.com](https://leanpub.com/ansible-for-devops) so you can take a look and see if it works for you.

NOTE: This repo is a work in progress.

# Intended usage
This repo can be used in a number of ways.
1. Run from a local machine to connect to an AWS (centos) instance.
  The local machine will need Ansible up and running:
  - run `pip3 install -r requirements.txt`
  - replace ansible.cfg with ansible_local.cfg
  The local machine will need the following AWS Setup:
  - ensure your instance is running (see start-aws.sh)
  - ensure ansible.cfg matches ansible_aws.cfg (this is the default)
  - ansible-playbook setup.yml (this will fetch this git repo and install python3, pip3 etc)

2. Run locally on a machine
  The local machine will need Ansible up and running:
  - run `pip3 install -r requirements.txt`
  - replace ansible.cfg with ansible_local.cfg
  Ability to ssh to localhost:
  - create (if needed) ssh-key pair and add to local authorized_keys
  - ensure `ssh localhost` works (add to known hosts if requried)

3. Run from an AWS (ubuntu) instance.
  The local machine will need Ansible up and running:
  - run `pip3 install -r requirements.txt`
  - replace ansible.cfg with ansible_local.cfg
  AWS Setup:
  - AWS instance setup (see Requires)
  - ensure your instance is running (see start-aws.sh)
  - ensure ansible.cfg matches ansible_aws.cfg (this is the default)
  - ansible-playbook setup.yml (this will fetch this git repo and install python3, pip3 etc)


## Requires
AWS (centos) Instance:
Ubuntu Image similar to:
ubuntu-bionic-18.04-amd64-server-20190722.1 "ami-077a5b1762a2dde35"

Security group with SSH access (often created as launch-wizard-1):
Inbound: SSH TCP 22 0.0.0.0/0 (or with your public ip)

Setup AWS access with the following:
~/.aws/.ssh/awsbox.pem - AWS Pem file for ssh to instance

~/.aws/config:
```
[default]
region=<REGION i.e. eu-west-2>
output=json
```

~/.aws/credentials:
```
[default]
aws_access_key_id=<AWS-KEY-ID>
aws_secret_access_key=<AWS-SECRET-KEY>
```
Note: To get a AWS Access Key & Secret you'll need to create additional user via the AWS Console in AIM.

Get the latest ec2.py and ec2.ini inventory script by running (or keep the one provided):
```
sh get_ec2_script.sh
```
Note: ec2.ini has been modified to select only instances with tag Project:BookClub
```
  all_instances = True
  instance_filters = tag:Project=BookClub
```
This ensures Ansible runs against just those instances.

## Usage
### sh info-aws.sh
Provides basic information about your aws instances (i.e. find your instance-id and public IP address (if running)).

### sh start-aws.sh <instance-id>
Starts the given instance (if already running/starting will display current status).

### sh stop-aws.sh <instance-id>
Stops the given instance (if already stopped/stopping will display current status).

### sh connect.sh <instance-ip-address>
Allows you to connect to the AWS instance (you will need to use the IP/hostname detailed in info-aws.sh or from previous ansible runs).
NOTE: Each time your instance is restarted the IP address/hostname will change!

## Playbooks
Run playbook:
```
ansible-playbook <playbook.yml>
```
Check playbook (makes no changes):
```
ansible-playbook <playbook.yml> --check
```
Perform lint checks on playbooks:
```
ansible-lint <playbook.yml>
```

### first-test.yml
Provides a quick test that Ansible is able to connect to target machine and run a command.

If you have problems ensure you are able to ssh directly to this machine (checks ssh keys).
i.e.
'''
# Check localhost ssh
ssh localhost
# Check AWS ssh
sh connect.sh <instance-ip-address>
'''

### setup.yml
Ensure you have python3 and pip3 installed, ready for the start of Chapter 01.

### shutdown.yml
Shutdown the instance through Ansible.

### ch01.yml
As explained in Chapter 01, this will install Ansible using pip3.
