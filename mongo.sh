apt-get install -y mongodb
apt-get install -y git-core

git clone https://github.com/mattjmorrison/django-buildout-template.git
git checkout remotes/origin/mongo -b monbo

cd django-buildout-template

python bootstrap.py

bin/buildout