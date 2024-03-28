#!/bin/sh

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg   && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list |     sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' |     sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=containerd

sudo apt install -y nvidia-container-runtime cuda-drivers-fabricmanager-515 nvidia-headless-515-server
# The following steps assume k3s is already installed and running
sudo systemctl stop k3s-agent.service 
sudo k3s-killall.sh 
sudo systemctl start k3s-agent.service 
sudo grep nvidia /var/lib/rancher/k3s/agent/etc/containerd/config.toml