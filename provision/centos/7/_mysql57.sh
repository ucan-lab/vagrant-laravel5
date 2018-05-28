#!/bin/bash -eu

echo -------------------------------------------------
echo
echo                    MySQL5.7
echo
echo -------------------------------------------------

yum -y install https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum -y install mysql-community-server

echo -------------------------------------------------
echo
echo                    MySQL 設定
echo
echo -------------------------------------------------

mv /etc/my.cnf /etc/my.cnf.org
cp $BASE_DIR/config/mysql57/my.cnf /etc/my.cnf
mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql
systemctl start mysqld
systemctl enable mysqld

echo -------------------------------------------------
echo
echo                    MySQL 初期設定
echo
echo -------------------------------------------------

DB_OLD_PASSWORD=`cat /var/log/mysql/mysql-error.log | grep 'temporary password' | awk -F ': ' '{print $NF}'`
# rootパスワード変更
mysqladmin -p${DB_OLD_PASSWORD} password ${DB_PASSWORD}
# リモートからのrootユーザでのログインの禁止
mysql -u root -p$DB_PASSWORD -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
# anonymousの削除
mysql -u root -p$DB_PASSWORD -e "DELETE FROM mysql.user WHERE User=''"
# testデータベースの削除
mysql -u root -p$DB_PASSWORD -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
# vagrantユーザーの作成
mysql -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'localhost' IDENTIFIED BY '$DB_PASSWORD'"
mysql -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'127.0.0.1' IDENTIFIED BY '$DB_PASSWORD'"
mysql -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'192.168.%' IDENTIFIED BY '$DB_PASSWORD'"
# 権限設定の反映
mysql -u root -p$DB_PASSWORD -e "FLUSH PRIVILEGES"

echo -------------------------------------------------
echo
echo                    MySQL ログイン設定
echo
echo -------------------------------------------------

cp $BASE_DIR/config/root/.mylogin.cnf /root/.mylogin.cnf
chmod 600 ~/.mylogin.cnf

echo -------------------------------------------------
echo
echo                    MySQL Version
echo
echo -------------------------------------------------

mysql --version
