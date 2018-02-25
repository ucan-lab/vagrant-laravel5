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
cp $PROVISION/dev/etc/my57.cnf /etc/my.cnf
mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql
systemctl start mysqld
systemctl enable mysqld

echo -------------------------------------------------
echo
echo                    MySQL 初期設定
echo
echo -------------------------------------------------

OLD_PASSWORD=`cat /var/log/mysql/mysql-error.log | grep 'temporary password' | awk -F ': ' '{print $NF}'`
NEW_PASSWORD=MySQL5.7
# rootパスワード変更
mysqladmin -p${OLD_PASSWORD} password ${NEW_PASSWORD}
# リモートからのrootユーザでのログインの禁止
mysql -u root -p"$NEW_PASSWORD" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
# anonymousの削除
mysql -u root -p"$NEW_PASSWORD" -e "DELETE FROM mysql.user WHERE User=''"
# testデータベースの削除
mysql -u root -p"$NEW_PASSWORD" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
# vagrantユーザーの作成
mysql -u root -p"$NEW_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO vagrant@localhost IDENTIFIED BY '$NEW_PASSWORD'"
# 権限設定の反映
mysql -u root -p"$NEW_PASSWORD" -e "FLUSH PRIVILEGES"

echo -------------------------------------------------
echo
echo                    MySQL ログイン設定
echo
echo -------------------------------------------------

cp $PROVISION/dev/root/.mylogin.cnf /root/.mylogin.cnf
cp $PROVISION/dev/root/.my.cnf /root/.my.cnf
chmod 600 ~/.mylogin.cnf
