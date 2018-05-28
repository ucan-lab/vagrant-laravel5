#!/bin/bash -eu

echo -------------------------------------------------
echo
echo                    MySQL5.6
echo
echo -------------------------------------------------

yum -y install https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum -y install yum-utils
yum-config-manager --disable mysql57-community
yum-config-manager --enable mysql56-community
yum -y install mysql-community-server mysql-community-devel

echo -------------------------------------------------
echo
echo                    MySQL 設定
echo
echo -------------------------------------------------

mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql

ln -sf $PROVISION/config/mysql56/my.cnf /etc/my.cnf -S .org

echo -------------------------------------------------
echo
echo                    MySQL 起動、自動起動
echo
echo -------------------------------------------------

systemctl start mysqld
systemctl enable mysqld

echo -------------------------------------------------
echo
echo                    MySQL 初期設定
echo
echo -------------------------------------------------

# rootユーザーパスワード設定
mysqladmin -u root password $DB_PASSWORD
# anonymasユーザー削除
mysql -u root -p$DB_PASSWORD -e "DELETE FROM mysql.user WHERE User='';"
mysql -u root -p$DB_PASSWORD -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
# testデータベース削除
mysql -u root -p$DB_PASSWORD -e "DROP DATABASE IF EXISTS test;"
mysql -u root -p$DB_PASSWORD -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
# vagrantユーザー作成
mysql -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'localhost' IDENTIFIED BY '$DB_PASSWORD'"
mysql -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'127.0.0.1' IDENTIFIED BY '$DB_PASSWORD'"
mysql -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'192.168.%' IDENTIFIED BY '$DB_PASSWORD'"
# 権限反映
mysql -u root -p$DB_PASSWORD -e "FLUSH PRIVILEGES;"

echo -------------------------------------------------
echo
echo                    MySQL ログイン設定
echo
echo -------------------------------------------------

cp $PROVISION/config/mysql56/.mylogin.root.cnf /root/.mylogin.cnf
cp $PROVISION/config/mysql56/.mylogin.vagrant.cnf /home/vagrant/.mylogin.cnf
chmod 600 /root/.mylogin.cnf
chmod 600 /home/vagrant/.mylogin.cnf
chown vagrant:vagrant /home/vagrant/.mylogin.cnf

echo -------------------------------------------------
echo
echo                    MySQL Version
echo
echo -------------------------------------------------

mysql --version
