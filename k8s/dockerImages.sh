#!/usr/bin/env bash

docker pull coredns/coredns:1.2.6
docker tag coredns/coredns:1.2.6 k8s.gcr.io/coredns:1.2.6
docker rmi coredns/coredns:1.2.6

docker pull jmgao1983/flannel:v0.11.0-amd64
docker tag jmgao1983/flannel:v0.11.0-amd64 k8s.gcr.io/flannel:v0.11.0-amd64
docker rmi jmgao1983/flannel:v0.11.0-amd64

images=(
    kube-apiserver:v1.13.4
    kube-controller-manager:v1.13.4
    kube-scheduler:v1.13.4
    kube-proxy:v1.13.4
    pause:3.1
    etcd:3.2.24
)

for imageName in ${images[@]}; do
    docker pull mirrorgooglecontainers/$imageName
    docker tag mirrorgooglecontainers/$imageName k8s.gcr.io/$imageName
    docker push mirrorgooglecontainers/$imageName
done

# scp /etc/kubernetes/k8s-key.tgz $CP1_IP:/etc/kubernetes
# ssh $CP1_IP 'tar xf /etc/kubernetes/k8s-key.tgz -C /etc/kubernetes/'
# scp /etc/kubernetes/k8s-key.tgz $CP2_IP:/etc/kubernetes
# ssh $CP2_IP 'tar xf /etc/kubernetes/k8s-key.tgz -C /etc/kubernetes/'
