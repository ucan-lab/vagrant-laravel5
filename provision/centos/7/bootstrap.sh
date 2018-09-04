#!/bin/bash -eu

echo -------------------------------------------------
echo
echo                    変数
echo
echo -------------------------------------------------

BASE_DIR=/vagrant/provision/centos/7
DB_PASSWORD=P@ssw0rd

echo -------------------------------------------------
echo
echo                    基本
echo
echo -------------------------------------------------

. $BASE_DIR/_base.sh

echo -------------------------------------------------
echo
echo                    Git
echo
echo -------------------------------------------------

. $BASE_DIR/_git2.sh

echo -------------------------------------------------
echo
echo                    PHP
echo
echo -------------------------------------------------

# . $BASE_DIR/_php71.sh
. $BASE_DIR/_php72.sh

echo -------------------------------------------------
echo
echo                    MySQL
echo
echo -------------------------------------------------

# . $BASE_DIR/_mysql56.sh
. $BASE_DIR/_mysql57.sh
# . $BASE_DIR/_mysql80.sh

echo -------------------------------------------------
echo
echo                    Nodejs, yarn
echo
echo -------------------------------------------------

. $BASE_DIR/_nodejs8.sh
. $BASE_DIR/_yarn.sh

echo -------------------------------------------------
echo
echo                    Heroku
echo
echo -------------------------------------------------

. $BASE_DIR/_heroku.sh

echo -------------------------------------------------
echo
echo                    PostgreSQL
echo
echo -------------------------------------------------

# . $BASE_DIR/_postgresql96.sh

echo -------------------------------------------------
echo
echo                    Redis
echo
echo -------------------------------------------------

# . $BASE_DIR/_redis3.sh
# . $BASE_DIR/_redis4.sh

echo -------------------------------------------------
echo
echo                    Permission
echo
echo -------------------------------------------------

# ログはvagrantユーザー見れるようにする
find /var/log -type d -exec chmod a+rx {} +
find /var/log -type f -exec chmod a+r {} +

echo -------------------------------------------------
echo
echo                    クリア
echo
echo -------------------------------------------------

yum clean all
history -c
