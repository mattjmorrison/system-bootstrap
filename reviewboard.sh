apt-get install -y git-core
apt-get install -y mysql-server
apt-get install -y python-virtualenv
mysqladmin -p create reviewboard
apt-get install -y python-mysqldb
apt-get install -y python-dev
apt-get install -y memcached
apt-get install -y patch

pip install python-memcached
pip install ReviewBoard
pip install virtualenvwrapper
echo "export WORKON_HOME=~/Envs" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
source ~/.bashrc
if [ ! -d $WORKON_HOME ]; then
        mkdir -p $WORKON_HOME
fi
mkvirtualenv default --no-site-packages
workon default

