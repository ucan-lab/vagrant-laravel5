echo -------------------------------------------------
echo
echo                    yarn
echo
echo -------------------------------------------------

curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
yum -y install yarn

echo -------------------------------------------------
echo
echo                    yarn Version
echo
echo -------------------------------------------------

yarn --version
