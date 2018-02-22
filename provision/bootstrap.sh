#!/bin/bash -eu

echo -------------------------------------------------
echo
echo                    yum 高速化設定
echo
echo -------------------------------------------------

cp /etc/yum/pluginconf.d/fastestmirror.conf /etc/yum/pluginconf.d/fastestmirror.conf.org

sed -e "s/^include_only//" /etc/yum/pluginconf.d/fastestmirror.conf
sed -e "s/^prefer//" /etc/yum/pluginconf.d/fastestmirror.conf

cat << EOS | sudo tee -a /etc/yum/pluginconf.d/fastestmirror.conf
include_only=.jp
prefer=ftp.iij.ad.jp
EOS

echo -------------------------------------------------
echo
echo                    基本設定
echo
echo -------------------------------------------------

yum -y update
yum -y install kernel kernel-devel
yum -y groupinstall "Base" "Development tools" "Japanese Support"

echo -------------------------------------------------
echo
echo                    便利ツール
echo
echo -------------------------------------------------

yum -y install epel-release tree pv dstat p7zip man-pages-ja

echo -------------------------------------------------
echo
echo                    タイムゾーン設定
echo
echo -------------------------------------------------

timedatectl set-timezone Asia/Tokyo

echo -------------------------------------------------
echo
echo                    言語、キーボード設定
echo
echo -------------------------------------------------

localedef -f UTF-8 -i ja_JP ja_JP.utf8
localectl set-locale LANG=ja_JP.utf8
localectl set-keymap jp106

echo -------------------------------------------------
echo
echo                    SELinux 無効化
echo
echo -------------------------------------------------

setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

echo -------------------------------------------------
echo
echo                    yum 自動更新設定
echo
echo -------------------------------------------------

yum -y install yum-cron
cp /etc/yum/yum-cron.conf /etc/yum/yum-cron.conf.org
sed -i 's/apply_updates = no/apply_updates = yes/' /etc/yum/yum-cron.conf
systemctl start yum-cron
systemctl enable yum-cron

echo -------------------------------------------------
echo
echo                    Git
echo
echo -------------------------------------------------

yum -y remove git
yum -y install https://centos7.iuscommunity.org/ius-release.rpm
yum -y install git2u

yum -y install yum-utils
yum-config-manager --disable ius

echo -------------------------------------------------
echo
echo                    PHP7.2, Apache2.4同梱
echo
echo -------------------------------------------------

# remiリポジトリ
yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
# PHP
yum -y install --enablerepo=remi-php72 php
# Laravel
yum -y install --enablerepo=remi-php72 php-pdo php-tokenizer php-openssl php-mbstring php-xml
# PHP-MySQL
yum -y install --enablerepo=remi-php72 php-mysqlnd

echo -------------------------------------------------
echo
echo                    Composer
echo
echo -------------------------------------------------

# Composer
yum -y install --enablerepo=remi-php72 php-zip
yum -y install --enablerepo=remi-php72 composer

echo -------------------------------------------------
echo
echo                    PHP 設定
echo
echo -------------------------------------------------

mv /etc/php.ini /etc/php.ini.org
cp /vagrant/provision/dev/etc/php.ini /etc/php.ini
mkdir -p /var/log/php
chown -R 777 /var/log/php
systemctl restart httpd

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
cp /vagrant/provision/dev/etc/my.cnf /etc/my.cnf
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

cp /vagrant/provision/dev/root/.mylogin.cnf /root/.mylogin.cnf
chmod 600 ~/.mylogin.cnf

echo -------------------------------------------------
echo
echo                    Nodejs8.x, yarn
echo
echo -------------------------------------------------

curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
yum -y install nodejs
wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
# yum -y install https://dl.yarnpkg.com/rpm/yarn.repo
yum -y install yarn

echo -------------------------------------------------
echo
echo                    chrony NTP設定
echo
echo -------------------------------------------------

yum -y install chrony
systemctl start chronyd
systemctl enable chronyd

echo -------------------------------------------------
echo
echo                    bash 設定
echo
echo -------------------------------------------------

\cp -f /vagrant/provision/dev/root/.bashrc ~/.bashrc
\cp -f /vagrant/provision/dev/root/.bash_aliases ~/.bash_aliases

echo -------------------------------------------------
echo
echo                    クリア
echo
echo -------------------------------------------------

yum clean all
history -c
