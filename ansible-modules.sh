#!/bin/bash

# Adds required modules so you can run the playbook

ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.general