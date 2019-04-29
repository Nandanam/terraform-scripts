#!/bin/bash

function install_java(){
        sudo yum -y install java-1.8.0-openjdk
		export JAVA_HOME=/usr/lib/jvm/java-*.x86_64/jre
		export PATH=$JAVA_HOME/bin:$PATH
		java -version

}

function check_error() {
			if [ $? = 0 ]
			then
				echo "setup successful"
			else
				echo "setup failure"
				exit 1
			fi
             }

function prereq_elasticsearch() {



# Accept the ElasticSearch GPG Key
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

cat > /etc/yum.repos.d/elasticsearch.repo << "EOF"
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum -v repolist

}

function install_elasticsearch() {
sudo yum -y install elasticsearch

#Use the chkconfig command to configure Elasticsearch to start automatically when the system boots up

chkconfig elasticsearch on

service elasticsearch start

service elasticsearch status

#echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml


}

# function validate_elasticsearch(){

#  curl -v localhost:9200
# }

#main
install_java
check_error
prereq_elasticsearch
check_error
install_elasticsearch
check_error
#sleep 60
#validate_elasticsearch
check_error
