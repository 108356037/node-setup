#!/bin/bash

sudo bash -c 'cat <<EOF > /etc/docker/daemon.json 
{
   "default-address-pools": [
        {
            "base":"172.17.0.0/12",
            "size":16
        },
        {
            "base":"192.168.0.0/16",
            "size":20
        },
        {
            "base":"10.99.0.0/16",
            "size":24
        }
    ]
}
EOF'

sudo systemctl restart docker

forta init --passphrase $FORTA_PASSPHRASE

sudo mkdir -p /etc/systemd/system/forta.service.d

sudo bash -c 'cat << EOF > /etc/systemd/system/forta.service.d/env.conf
[Service]
Environment="FORTA_DIR=/home/forta-user/.forta"
Environment="FORTA_PASSPHRASE=$FORTA_PASSPHRASE"
Restart=always
StartLimitBurst=2
StartLimitInterval=10
EOF'
