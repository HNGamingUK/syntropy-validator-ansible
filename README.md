# syntropy-validator-ansible

This GitHub repository has the required documents that can be used to deploy a single validator or even multiple.

Deployment of a single validator should take less than 10mins and for multiple validators under 1 hour.

The validator software is provided by Syntropy, more information about Syntropy can found [here](https://www.syntropynet.com/).

Notice: Please be aware this playbook just covers server hardening and container start up. It does not handle backups & monitoring which is highly suggested to setup! For assistance with setting up backups & monitoring for your validator(s) then I would suggest joining the discord [here](https://discord.gg/3gc9fzH4qd).

## Donate

If this has helped you in anyway and want to help me to continue updating this, by sending a little contribution then please do:

  - Ethereum Address: 0x9DE8aC561aEBBa42a1D322F101dFe02171e1D4Cb
  - Bitcoin  Address: bc1qa7fnea3vxcje5xywdchhuzr8u6az3mje95lxuv

## Contents

* [Assumptions](#assumptions)
* [Pre-reqs](#pre-reqs)
* [Steps to complete](#steps-to-complete)  
* [Advanced Users](#advanced-users)

## Assumptions

1. You have been provided your validator access key(s)
2. You have already ordered your VPS(') or dedicated server(s) and have been provided the login credentials  
3. The operating syetem of the VPS(') or dedicated server (s) is supported by the ansible playbook (see list below)
  - Debian 9, 10 & 11
  - Ubuntu 18.04 & 20.04
4. You have at least a basic understanding of working with Linux

## Pre-reqs

Your computer/ansible controller will need to have `ansible` installed, this can be completed by looking [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html). Be aware as mentioned within the site linked, Ansible does not support Windows and as such if you are on Windows I would suggest installing WSL(Windows Subsystem for Linux) using this guide [here](https://docs.microsoft.com/en-us/windows/wsl/install). After which you can start a Ubuntu flavor WSL and install Ansible. 

Your computer/ansible controller will need to have `git` installed, this can be completed by looking [here](https://git-scm.com/downloads).

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
    validator1_name: hnguk-validator1
    validator1_key: access1234
    ```
    5e. Use `ctrl + x` to exit, following on-screen information to save

6. Create Ansible ssh key  
`ssh-keygen -f ~/.ssh/ansible` - Press enter when asked for a passphrase

7. Create user ssh key  
`ssh-keygen -f ~/.ssh/my_user` - Replace `my_user` with same name entered in step 5d - Enter a passphrase when asked if you wish (this phrase will need to be entered whenever you manually login to the validator(s))

8. Inital Validator setup (Repeat if you plan to run multiple validators)  
  8a. Login to validator in a separate window with credentials provided  
  8b. Enter the following commands in order (for the final command replace `ansible public key` with the contents of `~/.ssh/ansible.pub` on your Ansible host)  
`sudo adduser ansible -gecos "" --disabled-password`  
`sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers`  
`sudo mkdir /home/ansible/.ssh`  
`sudo echo "ansible public key" > /home/ansible/.ssh/authorized_keys`  
  8c. Logout of validator

9. Edit the inventory file  
  9a. `nano inventory`  
  9b. Change `IP` to the IP address you recieved from your provider (if you plan to use mutliple validators add further entries and increment the validator number by 1)  
  9c. Use `ctrl + x` to exit, following on-screen information to save

10. Finally run the playbook!
`ansible-playbook -i inventory syntropy-validator.yaml`  

That's it! Your validator should now be online, you can confirm this by going to the telemetry ui and staking dashboard (links below)

* [Telemetry UI](https://telemetry-ui.syntropynet.com/)
* [Staking Dashboard](https://staking.syntropynet.com/)

## Advanced Users
The guide above is deffinately helpful for advanced users but there are potentially some methods of config that you have done differently to me. As such I have outlined them below so you know how to change them (if you want) to conform to your own standard.

1. Ansible config file
With this file you will see the sections I have made edits to are uncommented and have data entered. If the data located in the config file does not meet your standards feel free to make edits to make it work for you.

2. Ansible user
As per the guide above I use an `ansible` user that Ansible uses to login and make the config changes. With the private key being in `~/.ssh/ansible` if this is not how your setup works you will need to edit the config file as mentioned above.

3. Vault password file location
I store the vault password in `~/.vault_pass` if you store yours in a different location then you will need to change it on line 140 within the Ansible config file.

4. Vault file location
I store the vault file in `~/.vault.yaml` if you store yours in a different location then you will need to change it on line 5 within the playbook file.

5. Vault file contents
Please see `vault-example` file for the variables that need to be added to your vault file and edited with your own data.  