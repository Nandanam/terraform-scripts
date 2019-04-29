#!/bin/bash
sudo yum -y install java-1.8.0-openjdk
export JAVA_HOME=/usr/lib/jvm/java-*.x86_64/jre
export PATH=$JAVA_HOME/bin:$PATH
java -version
# Accept the ElasticSearch GPG Key
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat > /etc/yum.repos.d/elasticsearch.repo << "EOF"
[elasticsearch-2.x]
name=Elasticsearch repository for 2.x packages
baseurl=https://packages.elastic.co/elasticsearch/2.x/centos
gpgcheck=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

sudo yum -v repolist

sudo yum -y install elasticsearch

#Use the chkconfig command to configure Elasticsearch to start automatically when the system boots up

sudo chkconfig elasticsearch on

sudo systemctl start elasticsearch.service

sudo service elasticsearch status