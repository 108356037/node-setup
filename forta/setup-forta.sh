#!/bin/bash

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
