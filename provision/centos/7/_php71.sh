#!/bin/bash -eu

echo -------------------------------------------------
echo
echo                    PHP7.1, Apache2.4同梱
echo
echo -------------------------------------------------

# remiリポジトリ
yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
# PHP
yum -y install --enablerepo=remi-php71 php
# Laravel
yum -y install --enablerepo=remi-php71 php-pdo php-tokenizer php-openssl php-mbstring php-xml
# PHP-MySQL
yum -y install --enablerepo=remi-php71 php-mysqlnd

echo -------------------------------------------------
echo
echo                    Composer
echo
echo -------------------------------------------------

# Composer
yum -y install --enablerepo=remi-php71 php-zip composer

echo -------------------------------------------------
echo
echo                    PHP 設定
echo
echo -------------------------------------------------

mv /etc/php.ini /etc/php.ini.org
cp $BASE_DIR/config/php71/php.ini /etc/php.ini
mkdir -p /var/log/php
chown -R 777 /var/log/php
systemctl restart httpd

echo -------------------------------------------------
echo
echo                    PHP Version
echo
echo -------------------------------------------------

php --version

echo -------------------------------------------------
echo
echo                    Composer Version
echo
echo -------------------------------------------------

composer --version
