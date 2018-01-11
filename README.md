# Vagrant Laravel5.5

CentOS7でLaravel5.5が動作する環境を構築します。

## 仮想環境の各ライブラリのバージョン情報

```
$ cat /etc/redhat-release
CentOS Linux release 7.4.1708 (Core)
$ git --version
git version 2.15.1
$ php -v
PHP 7.1.13 (cli) (built: Jan  3 2018 11:00:58) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2017 Zend Technologies
$ composer -V
Composer version 1.5.6 2017-12-18 12:09:18
$ mysql -V
mysql  Ver 14.14 Distrib 5.7.20, for Linux (x86_64) using  EditLine wrapper
$ httpd -v
Server version: Apache/2.4.6 (CentOS)
Server built:   Oct 19 2017 20:39:16
$ node -v
v8.9.4
$ npm -v
5.6.0
$ yarn -v
1.3.2
$ mysql -e "SHOW VARIABLES LIKE '%character%'"
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8mb4                    |
| character_set_connection | utf8mb4                    |
| character_set_database   | utf8mb4                    |
| character_set_filesystem | binary                     |
| character_set_results    | utf8mb4                    |
| character_set_server     | utf8mb4                    |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
```

## 要件

- [Vagrant](https://www.vagrantup.com)
- [VirtualBox](https://www.virtualbox.org)

### 推奨プラグイン

```
$ vagrant plugin install vagrant-share
$ vagrant plugin install vagrant-vbguest
```

## 環境構築

```
$ git clone https://github.com/ucan-lab/vagrant-laravel55 ./example
$ cd example
$ cp Vagrantfile.example Vagrantfile
$ vagrant up
```

## Git初期化

```
$ rm -rf .git
$ git init
$ git add .
$ git commit -m "first commit"
```

## Laravelインストール例

```
$ vagrant ssh
* 以降、仮想環境内で実施
$ composer create-project --prefer-dist laravel/laravel blog "5.5.*"
```

`blog` のインストール先ディレクトリ名は適宜変更ください。

### MySQLデータベース作成

```
$ mysql -u vagrant -pMySQL5.7
> CREATE DATABASE blog;
> exit
```

MySQLへログイン＆データベースを作成する。

### MySQLデータベース設定

```
$ cd blog
* 以降、カレントディレクトリを blog とする
sed -i -e 's/DB_DATABASE=homestead/DB_DATABASE=blog/' .env
sed -i -e 's/DB_USERNAME=homestead/DB_USERNAME=vagrant/' .env
sed -i -e 's/DB_PASSWORD=secret/DB_PASSWORD=MySQL5.7/' .env
```

.env が無い場合は .env.example をコピーして作成する

### ビルトインサーバ起動

```
$ php artisan serve --host 0.0.0.0
```

http://192.168.33.10:8000

![Laravel](https://i.gyazo.com/048e0a29861b003a33bea354f755b03e.png)

