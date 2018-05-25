#!/bin/bash -eu

echo -------------------------------------------------
echo
echo                    Redis
echo
echo -------------------------------------------------

yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum -y install redis --enablerepo=remi

systemctl start redis
systemctl enable redis

echo -------------------------------------------------
echo
echo                    Redis Version
echo
echo -------------------------------------------------

redis-cli --version
redis-cli ping
