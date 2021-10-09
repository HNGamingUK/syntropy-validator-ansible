# syntropy-validator-ansible
Ansible repo to setup a Syntropy Validator

## Pre-reqs
Ansible host will obbviously need to have Ansible installed, this can be completed using the following guide: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

Install git on Ansible host using the following guide: https://git-scm.com/downloads

## Steps to install

1. Clone this repo
`git clone https://github.com/HNGamingUK/syntropy-validator-ansible.git`

2. cd into cloned repo
`cd syntropy-validator-ansible`

3. Run script to install required ansible modules
`./ansible-modules.sh`

4. Create Ansible vault password file and enter a password
  4a. `nano ~/.vault-pass`
  4b. Enter password of your choice
  4c. Use `ctrl + x` to exit, following on-screen information to save

5. Create an Ansible vault, follow on-screen instructions on creating password
  5a. `ansible-vault create ~/.vault.yaml`
  5b. Add below information to the file replacing the information as you require (id number can be left at 1111) 
```
my_id: 1111
my_user: hnguk
my_password: password1234
root_password: password4321
validator_name: hnguk-validator
access_key: access1234
```
  5c. Use `ctrl + x` to exit, following on-screen information to save

6. Create Ansible ssh key
`ssh-keygen -f ~/.ssh/ansible`

7. Create user ssh key
`ssh-keygen -f ~/.ssh/my_user` - Replace `my_user` with same name entered in step 5b

8. Login to your validator server with provided details and run the following commmands to setup the Ansible user - replace `ansible public key` with the contents of `~/.ssh/ansible.pub`
```
sudo adduser ansible -gecos "" --disabled-password
sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
sudo mkdir /home/ansible/.ssh
sudo echo "ansible public key" > /home/ansible/.ssh/authorized_keys
```

9. Edit inventory file to have the hostname of your validator (You can either setup local DNS using the your systems host file or add `ansible_host=IP` after the hostname)
  10a. `nano inventory`
  10b. Change list of hostname(s) to your own validator hostname(s)
  10c. Use `ctrl + x` to exit, following on-screen information to save

10. Finally run the playbook!
`ansible-playbook -i hosts syntropy-validator.yaml`