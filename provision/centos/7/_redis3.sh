#!/bin/bash -eu

echo -------------------------------------------------
echo
echo                    Redis
echo
echo -------------------------------------------------

yum -y install epel-release
yum -y install redis --enablerepo=epel

systemctl start redis
systemctl enable redis

echo -------------------------------------------------
echo
echo                    Redis Version
echo
echo -------------------------------------------------

redis-cli --version
redis-cli ping
