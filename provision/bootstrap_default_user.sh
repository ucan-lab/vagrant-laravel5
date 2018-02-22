#!/bin/bash -eu

# vagrant ユーザーで実行する

echo -------------------------------------------------
echo
echo                    MySQL ログイン設定
echo
echo -------------------------------------------------

cp /vagrant/provision/dev/home/vagrant/.mylogin.cnf ~/.mylogin.cnf
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
echo                    bash 高速化
echo
echo -------------------------------------------------

cp /vagrant/provision/dev/home/vagrant/.bashrc ~/.bashrc
cp /vagrant/provision/dev/home/vagrant/.bash_aliases ~/.bash_aliases

echo -------------------------------------------------
echo
echo                    vim 設定
echo
echo -------------------------------------------------

git clone http://github.com/VundleVim/Vundle.Vim.git ~/.vim/bundle/vundle
cp /vagrant/provision/dev/home/vagrant/.vimrc ~/.vimrc
vim +BundleInstall +qa
