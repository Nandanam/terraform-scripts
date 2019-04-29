#!/bin/sh
# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

yum -y update
yum -y install wget 
cd /etc/yum.repos.d/
wget https://raw.githubusercontent.com/phanikishorelanka/docker-k8s-pklanka/master/mongo.repo
cp /etc/security/limits.conf /etc/security/limits.conf.orig
echo mongod soft nofile 64000  >>/etc/security/limits.conf
echo mongod hard nofile 64000 >>/etc/security/limits.conf
sysctl -p

yum -y install mongodb-org
wget https://raw.githubusercontent.com/phanikishorelanka/docker-k8s-pklanka/master/vikas_scripts/sample.js
service mongod start
