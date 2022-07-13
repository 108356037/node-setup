#!/bin/bash

export username=forta-user
adduser --disabled-password --shell /bin/bash --gecos "User" $username
mkdir /home/$username/.ssh
cp /root/.ssh/authorized_keys /home/$username/.ssh/authorized_keys
chown -R $username:$username /home/$username/.ssh/
usermod -aG sudo $username
echo 'forta-user ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo
