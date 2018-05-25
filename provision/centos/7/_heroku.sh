echo -------------------------------------------------
echo
echo                    heroku-cli
echo
echo -------------------------------------------------

wget https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz -O heroku.tar.gz
mkdir -p /usr/local/lib/heroku
tar --strip-components 1 -zxvf heroku.tar.gz -C /usr/local/lib/heroku 1>/dev/null
ln -s /usr/local/lib/heroku/bin/heroku /usr/local/bin/heroku
rm -f heroku.tar.gz
