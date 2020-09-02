#!/bin/bash

sudo mkfs -t ext4 /dev/xvdh
sudo mkdir -p /data
sudo mount /dev/xvdh /data
sudo cp /etc/fstab /etc/fstab.bak
sudo bash
sudo echo "dev/xvdh		/data	ext4	defaults,discard	0 0" >> /etc/fstab
sudo mount -a

sudo apt-get install mysql-client -y 