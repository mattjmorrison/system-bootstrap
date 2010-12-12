#!/bin/bash

# Setup RabbitMQ
apt-get install -y rabbitmq-server
rabbitmqctl add_user myuser mypassword
rabbitmqctl add_vhost myvhost
rabbitmqctl set_permissions -p myvhost myuser ".*" ".*" ".*"

# install Git
apt-get install -y git-core

# checkout the Django-Celery-Buildout app
git clone https://github.com/mattjmorrison/django-celery-buildout.git

# Setup the Django-Celery-Buildout app
cd django-celery-buildout
python bootstrap.py
bin/buildout
bin/manage.py syncdb

bin/manage.py runserver 0.0.0.0:80 &
bin/manage.py celeryd &