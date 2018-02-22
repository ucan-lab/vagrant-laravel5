# Vagrant Laravel5.5

CentOS7でLaravel5.5が動作する環境を構築します。

# 設定値

項目 | 値
--- | ---
IP | 192.168.99.99
ドキュメントルート | /var/www/html
URL | http://192.168.99.99
マウント場所 | ./ <=> /var/www/html
MySQLユーザー | vagrant
MySQLパスワード | MySQL5.7

# リンク

- [Vagrant](https://www.vagrantup.com)
- [VirtualBox](https://www.virtualbox.org)
- [Macの初期設定参考リンク](https://github.com/ucan-lab/tips/issues/3)

# プラグイン

```
$ vagrant plugin install vagrant-share vagrant-vbguest
```

# 環境構築

```
$ git clone https://github.com/ucan-lab/vagrant-laravel55
$ cd vagrant-laravel55
$ vagrant up
```
