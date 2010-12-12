#!/bin/bash

apt-get install -y rabbitmq-server
rabbitmqctl add_user myuser mypassword
rabbitmqctl add_vhost myvhost
rabbitmqctl set_permissions -p myvhost myuser ".*" ".*" ".*"

apt-get install -y git-core
git clone https://github.com/mattjmorrison/django-celery-buildout.git

cd django-celery-buildout
python bootstrap.py
bin/buildout
