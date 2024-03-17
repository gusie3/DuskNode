#!/bin/bash
# Update and upgrade
sudo apt update && sudo apt upgrade -y

#2.Install the essential libraries
sudo apt install curl build-essential git screen jq pkg-config libssl-dev libclang-dev ca-certificates gnupg lsb-release -y


# Install docker and docker-compose
curl -fsSL https://get.docker.com | sh && ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin

# Install Rusk
curl --proto '=https' --tlsv1.2 -sSfL https://github.com/dusk-network/itn-installer/releases/download/v0.1.0/itn-installer.sh | sudo sh

#Restore Wallet
rusk-wallet restore

#Export Consensus Key
rusk-wallet export -d /opt/dusk/conf -n consensus.keys

# Set an encryption password for the consensus key
sh /opt/dusk/bin/setup_consensus_pwd.sh
#go the taiko directory

#Start Rusk
service rusk start

#Your node is now syncing. To confirm:
grep "block accepted" /var/log/rusk.log

#Stake (minimum stake is 1000)
rusk-wallet stake --amt 1000

#View Stake Info
rusk-wallet stake-info

# To see if your node is participating in consensus and creating blocks:
tail -F /var/log/rusk.log | grep "execute_state_transition"
