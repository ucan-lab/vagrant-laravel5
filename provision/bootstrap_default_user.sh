#!/bin/sh

# デフォルトユーザー(vagrant)で実行する

# bash
cp /vagrant/provision/dev/home/vagrant/.bashrc ~/.bashrc
cp /vagrant/provision/dev/home/vagrant/.bash_aliases ~/.bash_aliases

# git の出力に色を付ける
git config --global color.ui true
# git パーミッションの変更を無視
git config --global core.filemode false
# git ファイル名の大文字・小文字の変更を検知
git config --global core.ignorecase false

# データベース
cp /vagrant/provision/dev/home/vagrant/.mylogin.cnf ~/.mylogin.cnf
chmod 600 ~/.mylogin.cnf

# git の出力に色を付ける
git config --global color.ui true
# git パーミッションの変更を無視
git config --global core.filemode false
# git ファイル名の大文字・小文字の変更を検知
git config --global core.ignorecase false

# ミラーサイトの有効化
composer config -g repos.packagist composer https://packagist.jp
# 並列化プラグインのインストール
composer global require hirak/prestissimo
# キャッシュクリア
composer clear-cache
