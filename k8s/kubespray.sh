#!/usr/bin/env bash

yum install epel-release -y
yum install git python python-pip -y
pip install pip --upgrade -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
pip install --no-cache-dir ansible -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com

ssh-keygen -t rsa -b 2048

ipList=(192.168.56.108 10.10.75.104 10.10.75.106)

for n in ${ipList[@]}; do
  echo $n
  ssh-copy-id -i ~/.ssh/id_rsa.pub support@$n
done
