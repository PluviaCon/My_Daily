#!/usr/bin/env bash

systemctl stop firewalld && systemctl disable firewalld
swapoff -a

sed -i '/ swap / s/^/#/' /etc/fstab

cat >>/etc/hosts <<EOF
  192.168.56.104 master1
  192.168.56.108 master2
  192.168.56.106 node1
  192.168.56.107 node2
EOF

ssh-keygen -t rsa

ipList=(192.168.56.108 192.168.56.106 192.168.56.107)

for n in ${ipList[@]}; do
  echo $n
  ssh-copy-id -i ~/.ssh/id_rsa.pub root@$n
done

yum install epel-release wget yum-utils net-tools -y
yum update

yum erase firewalld firewalld-filesystem python-firewall -y

yum install git python python-pip -y

mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all
yum makecache

yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

cat <<EOF >/etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://f6j1klbv.mirror.aliyuncs.com"]
}
EOF
yum install -y docker-ce kubelet kubeadm kubectl
systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet

sudo systemctl daemon-reload
sudo systemctl restart docker

docker --version
systemctl status docker
systemctl start docker &
systemctl enable docker

echo Environment='"KUBELET_CGROUP_ARGS=--cgroup-driver=systemd"' >>/etc/docker/daemon.json
systemctl daemon-reload

tee /etc/docker/daemon.json <<-'EOF'
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
systemctl restart docker
systemctl status docker
