echo -------------------------------------------------
echo
echo                    Nodejs8.x, yarn
echo
echo -------------------------------------------------

curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
yum -y install nodejs

echo -------------------------------------------------
echo
echo                    Node Version
echo
echo -------------------------------------------------

node --version

echo -------------------------------------------------
echo
echo                    npm Version
echo
echo -------------------------------------------------

npm --version
