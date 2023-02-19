#!/bin/bash

if [ "$FORTA_PASSPHRASE" == "" ]; then
    echo "env FORTA_PASSPHRASE must be set!"
    exit 1 
fi

if [ "$TARGET_USER" == "" ]; then
    echo "env TARGET_USER must be set!"
    exit 1 
fi

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

cat << EOF > env.conf
[Service]
Environment="FORTA_DIR=/home/$TARGET_USER/.forta"
Environment="FORTA_PASSPHRASE=$FORTA_PASSPHRASE"
Restart=always
StartLimitBurst=2
StartLimitInterval=10
EOF

sudo mv ./env.conf /etc/systemd/system/forta.service.d
