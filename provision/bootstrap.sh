#!/bin/sh

cp /etc/yum/pluginconf.d/fastestmirror.conf /etc/yum/pluginconf.d/fastestmirror.conf.org

sed -e "s/^include_only//" /etc/yum/pluginconf.d/fastestmirror.conf
sed -e "s/^prefer//" /etc/yum/pluginconf.d/fastestmirror.conf

cat << EOS | sudo tee -a /etc/yum/pluginconf.d/fastestmirror.conf
include_only=.jp
prefer=ftp.iij.ad.jp
EOS

# yumのアップデート
yum -y update
# カーネル
yum -y install kernel kernel-devel
# 開発ツールの導入
yum -y groupinstall "Base" "Development tools" "Japanese Support"
# 便利ツール
yum -y install epel-release
yum -y install tree pv dstat p7zip fish

# マニュアルの日本語化
yum -y install man-pages-ja

# タイムゾーン設定
timedatectl set-timezone Asia/Tokyo

# 言語、キーボード設定
localedef -f UTF-8 -i ja_JP ja_JP.utf8
localectl set-locale LANG=ja_JP.utf8
localectl set-keymap jp106

# SELinuxの無効化
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

# yum-cron
yum -y install yum-cron
cp /etc/yum/yum-cron.conf /etc/yum/yum-cron.conf.org
sed -i 's/apply_updates = no/apply_updates = yes/' /etc/yum/yum-cron.conf
systemctl start yum-cron
systemctl enable yum-cron

# bash
\cp -f /vagrant/provision/dev/root/.bashrc ~/.bashrc
\cp -f /vagrant/provision/dev/root/.bash_aliases ~/.bash_aliases

## Git

yum -y remove git
yum -y install https://centos7.iuscommunity.org/ius-release.rpm
yum -y install git2u

yum -y install yum-utils
yum-config-manager --disable ius

# PHP7.1のインストール
# yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
## ミラーサイト
yum -y install http://remi.conetix.com.au/enterprise/remi-release-7.rpm
yum -y install --enablerepo=remi-php71 php
## Laravel
yum -y install --enablerepo=remi-php71 php-pdo php-tokenizer php-openssl php-mbstring php-xml
## PHP-MySQL
yum -y install --enablerepo=remi-php71 php-mysqlnd
## Composer
yum -y install --enablerepo=remi-php71 php-zip
## PHP settings
mv /etc/php.ini /etc/php.ini.org
cp /vagrant/provision/dev/etc/php.ini /etc/php.ini
mkdir -p /var/log/php
chown -R 777 /var/log/php
systemctl restart httpd

# Composer
yum -y install --enablerepo=remi-php71 composer

# MySQL5.7 のインストール
yum -y install https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum -y install mysql-community-server
mv /etc/my.cnf /etc/my.cnf.org
cp /vagrant/provision/dev/etc/my.cnf /etc/my.cnf
mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql
systemctl start mysqld
systemctl enable mysqld

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

# ログイン情報
cp /vagrant/provision/dev/root/.mylogin.cnf /root/.mylogin.cnf
chmod 600 ~/.mylogin.cnf

## Nodejs, yarn
yum -y install nodejs --enablerepo=epel
wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
yum -y install yarn

## chrony
yum -y install chrony
systemctl start chronyd
systemctl enable chronyd

# クリア
yum clean all
history -c
