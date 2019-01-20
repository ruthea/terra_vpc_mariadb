#!/bin/bash -v
yum -y install git
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install ansible
git clone https://github.com/ruthea/standard_replication.git
chmod 0600 /tmp/test.pem
