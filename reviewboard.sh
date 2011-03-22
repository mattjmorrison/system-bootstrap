
apt-get install -y git-core
apt-get install -y mysql-server
apt-get install -y python-virtualenv
apt-get install -y python-mysqldb
apt-get install -y python-dev
apt-get install -y memcached
apt-get install -y patch


# Create python virtualenv
pip install virtualenvwrapper
echo "export WORKON_HOME=~/Envs" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
source ~/.bashrc
if [ ! -d $WORKON_HOME ]; then
        mkdir -p $WORKON_HOME
fi
mkvirtualenv default --no-site-packages
workon default

#install python packages
pip install python-memcached
pip install ReviewBoard



mysqladmin -p create reviewboard


