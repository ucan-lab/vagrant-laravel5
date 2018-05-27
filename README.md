# Vagrant Laravel5

CentOS7でLaravel5が動作する環境を構築します。

# 環境構築

```
$ git clone https://github.com/ucan-lab/vagrant-laravel5
$ cd vagrant-laravel5
$ cp Vagrantfile.example Vagrantfile
$ vagrant up
```

# 設定値

項目 | 値
--- | ---
IP | 192.168.33.99
ドキュメントルート | /var/www/html
URL | http://192.168.33.99
マウント場所 | ./ <=> /var/www/html
MySQLユーザー | vagrant
MySQLパスワード | MySQL5.7

# リンク

- [Vagrant&VirtualBoxインストール手順](https://github.com/ucan-lab/vagrant-laravel5/wiki/mac-vagrant-virtualbox-install)
- [Laravel5.5をインストールする例](https://github.com/ucan-lab/vagrant-laravel5/wiki/laravel5.5-install-example)
- [Laravelプロジェクトをgit cloneする例](https://github.com/ucan-lab/vagrant-laravel5/wiki/laravel-project-git-clone-example)
- [エイリアス設定](https://github.com/ucan-lab/vagrant-laravel5/blob/master/provision/project/.bash_aliases)
