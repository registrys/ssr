#!/bin/bash

# 更新软件包，安装基础软件包
yum update -y && yum install -y wget git vim epel-release
# 安装网络监控软件
yum install -y iftop nload nethogs

# 安装 docker 并启用
wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.13-3.1.el7.x86_64.rpm && yum install containerd.io-1.2.13-3.1.el7.x86_64.rpm && rm -f containerd.io-1.2.13-3.1.el7.x86_64.rpm
curl -fsSL https://get.docker.com | bash
systemctl start docker
systemctl enable docker

# 安装 docker-commpose
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/1.25.5/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

# 开启 BBR
echo "net.core.default_qdisc=fq" | sudo tee --append /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee --append /etc/sysctl.conf
sysctl -p
