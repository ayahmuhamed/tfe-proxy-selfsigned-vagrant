#!/usr/bin/env bash

ip="192.168.50.10"

# TFE installation
cp /vagrant/config/replicated.conf /etc/replicated.conf
curl -o install.sh https://install.terraform.io/ptfe/stable
bash ./install.sh no-proxy private-address=${ip} public-address=${ip}
usermod -aG docker vagrant
