#!/bin/bash -eu

# vagrant ユーザーで実行する

echo -------------------------------------------------
echo
echo                    変数
echo
echo -------------------------------------------------

BASE_DIR=/vagrant/provision/centos/7

echo -------------------------------------------------
echo
echo                    MySQL ログイン設定
echo
echo -------------------------------------------------

cp $BASE_DIR/config/vagrant/.mylogin.cnf ~/.mylogin.cnf
chmod 600 ~/.mylogin.cnf

echo -------------------------------------------------
echo
echo                    Git 設定
echo
echo -------------------------------------------------

# git の出力に色を付ける
git config --global color.ui true
# git パーミッションの変更を無視
git config --global core.filemode false
# git ファイル名の大文字・小文字の変更を検知
git config --global core.ignorecase false

echo -------------------------------------------------
echo
echo                    Composer 高速化
echo
echo -------------------------------------------------

# ミラーサイトの有効化
composer config -g repos.packagist composer https://packagist.jp
# 並列化プラグインのインストール
composer global require hirak/prestissimo
# キャッシュクリア
composer clear-cache

echo -------------------------------------------------
echo
echo                    Laravel インストーラ
echo
echo -------------------------------------------------

composer global require "laravel/installer"

echo -------------------------------------------------
echo
echo                     SSH設定
echo
echo -------------------------------------------------

\cp -f $BASE_DIR/config/vagrant/.ssh/config ~/.ssh

echo -------------------------------------------------
echo
echo                    プロジェクト設定
echo
echo -------------------------------------------------

\cp -f $BASE_DIR/../../project/.bash_aliases ~/.bash_aliases
\cp -f $BASE_DIR/../../project/.bashrc ~/.bashrc
\cp -f $BASE_DIR/../../project/.zsh_aliases ~/.zsh_aliases
\cp -f $BASE_DIR/../../project/.zshrc ~/.zshrc
ln -sf /var/www/html ~/html
