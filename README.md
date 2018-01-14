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
$ git clone https://github.com/ucan-lab/vagrant-laravel55 ./project_name
$ cd project_name
$ vagrant up
```

## Git初期化

```
$ rm -rf .git
$ git init
$ git add .
$ git commit -m "first commit"
```

## Git設定

```
$ vagrant ssh
* 以降のコマンドは仮想環境内で実施

$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

## Laravelインストール例

```
$ composer create-project --prefer-dist laravel/laravel temp "5.5.*"
$ mv temp/* laravel
$ mv temp/.* laravel

$ cd laravel
$ git add .
$ git commit -m "laravel install"
```

既にファイルが存在するディレクトリに対して `create-project` できないため temp ディレクトリにLaravelをインストールし、ファイルを移動する。

### MySQLデータベース作成

```
$ mysql -u vagrant -pMySQL5.7
> CREATE DATABASE laravel;
> exit
```

MySQLへログイン＆データベースを作成する。

### MySQLデータベース設定

```
$ cd laravel
* 以降、カレントディレクトリを laravel とする
sed -i -e 's/DB_DATABASE=homestead/DB_DATABASE=laravel/' .env
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
