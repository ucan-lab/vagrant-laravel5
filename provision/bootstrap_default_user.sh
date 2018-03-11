#!/bin/bash -eu

# vagrant ユーザーで実行する

echo -------------------------------------------------
echo
echo                    設定
echo
echo -------------------------------------------------

PROVISION=/vagrant/provision

echo -------------------------------------------------
echo
echo                    MySQL ログイン設定
echo
echo -------------------------------------------------

cp $PROVISION/dev/home/vagrant/.mylogin.cnf ~/.mylogin.cnf

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
echo                    dotfiles
echo
echo -------------------------------------------------

git clone https://github.com/ucan-lab/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
