# syntropy-validator-ansible

This GitHub repository has the required documents that can be used to deploy a single validator or even multiple.

Deployment of a single validator should take less than 10mins and for multiple validators under 1 hour

## Assumptions

1. You have already ordered your VPS or dedicated server and have been provided the login credentials  
2. The operating system of your server is either Ubuntu 18.04 or 20.04  
3. You have at least basic understanding working with Linux

## Pre-reqs
Ansible host will need to have `ansible` installed, this can be completed by looking here: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

Ansible host will need to have `git` installed, this can be completed by looking here: https://git-scm.com/downloads

## Steps to complete

1. Clone this repo
`git clone https://github.com/HNGamingUK/syntropy-validator-ansible.git`

2. cd into cloned repo
`cd syntropy-validator-ansible`

3. Run script to install required ansible modules
`./ansible-modules.sh`

4. Create Ansible vault password file
  4a. `nano ~/.vault_pass`  
  4b. Enter password of your choice  
  4c. Use `ctrl + x` to exit, following on-screen information to save

5. Create an Ansible vault
  5a. Copy contents of `vault-example` 
  5b. `ansible-vault create ~/.vault.yaml`  
  5c. Paste copied content into nano window
  5d. Edit information to values as required (ID can be left at 1111 if you wish), if you plan to deploy multiple validators then repeat section below (incrementing the validator number by 1 each time):
```
validator1_name: hnguk-validator
validator1_key: access1234
```
  5e. Use `ctrl + x` to exit, following on-screen information to save

6. Create Ansible ssh key
`ssh-keygen -f ~/.ssh/ansible`

7. Create user ssh key
`ssh-keygen -f ~/.ssh/my_user` - Replace `my_user` with same name entered in step 5d

8. Inital Validator setup (only time you should need to login to the validator manually)
  8a. Login to validator in a separate window with credentials provided
  8b. Enter the following commands in order (for the final command replace `ansible public key` with the contents of `~/.ssh/ansible.pub` on your Ansible host)  
`sudo adduser ansible -gecos "" --disabled-password`
`sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers`
`sudo mkdir /home/ansible/.ssh`
`sudo echo "ansible public key" > /home/ansible/.ssh/authorized_keys`

9. Edit the inventory file
  10a. `nano inventory`  
  10b. Add `ansible_host=IP` after the validator entry (if you plan to use mutliple validators add further entries and increment the number by 1)  
  10c. Use `ctrl + x` to exit, following on-screen information to save

10. Finally run the playbook!
`ansible-playbook -i inventory syntropy-validator.yaml`