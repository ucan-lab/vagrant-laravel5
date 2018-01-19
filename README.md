# Vagrant Laravel5.5

CentOS7でLaravel5.5が動作する環境を構築します。

## 仮想環境の各ライブラリのバージョン情報

- CentOS7.x
- PHP7.1.x
- MySQL5.7
- composer 1.5.x
- httpd 2.4.x
- node 8.9.x
- npm 5.6.x
- yarn 1.3.x

## 要件

- [Vagrant](https://www.vagrantup.com)
- [VirtualBox](https://www.virtualbox.org)

### 推奨プラグイン

```
$ vagrant plugin install vagrant-share vagrant-vbguest
```

## 環境構築

```
$ mkdir ~/projects
$ cd ~/projects
$ git clone https://github.com/ucan-lab/vagrant-laravel55
$ cd vagrant-laravel55
$ vagrant up
```

## Git設定

```
$ vagrant ssh
* 以降のコマンドは仮想環境内で実施

$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

仮想環境内でGitを使用する場合は必ず設定しておく

## Laravelインストール例

### プロジェクトディレクトリを作成

```
$ mkdir ~/projects/project_name
```

### 共有フォルダ設定（Vagrantfile）

```
  config.vm.synced_folder '../project_name', '/home/vagrant/project_name'
```

Vagrantfileに追記して設定を反映

```
$ vagrant reload
```

### Laravel インストール

```
$ vagrant ssh
$ composer create-project --prefer-dist laravel/laravel project_name "5.5.*"
$ cd project_name
$ git add .
$ git commit -m "laravel install"
```

### MySQLデータベース作成

```
$ mysql -u vagrant -pMySQL5.7
> CREATE DATABASE project_name;
> exit
```

MySQLへログイン＆データベースを作成する。

### MySQLデータベース設定

```
$ cd project_name
$ sed -i -e 's/DB_DATABASE=homestead/DB_DATABASE=project_name/' .env
$ sed -i -e 's/DB_USERNAME=homestead/DB_USERNAME=vagrant/' .env
$ sed -i -e 's/DB_PASSWORD=secret/DB_PASSWORD=MySQL5.7/' .env
```

### ビルトインサーバ起動

```
$ php artisan serve --host 0.0.0.0
```

http://192.168.33.10:8000

![Laravel](https://i.gyazo.com/048e0a29861b003a33bea354f755b03e.png)

