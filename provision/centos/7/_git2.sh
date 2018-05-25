echo -------------------------------------------------
echo
echo                    Git2
echo
echo -------------------------------------------------

yum -y remove git
yum -y install https://centos7.iuscommunity.org/ius-release.rpm
yum -y install git2u

yum -y install yum-utils
yum-config-manager --disable ius

echo -------------------------------------------------
echo
echo                    Git Version
echo
echo -------------------------------------------------

git --version
