# Tested with Ubuntu 10.10 (Maverick Meerkat)

# To run use:
# wget --no-check-certificate https://raw.github.com/mattjmorrison/system-bootstrap/master/chishop.sh && source chishop.sh

# install system dependencies
aptitude install git-core apache2 python-setuptools libapache2-mod-wsgi -y

# Get chishop
git clone git://github.com/mattjmorrison/chishop.git

# setup chishop application
cd chishop
python bootstrap.py -d
bin/buildout
bin/django syncdb --noinput
bin/django createsuperuser --username admin --email admin@apps-system.com
chmod 755 .. -R
chown www-data:www-data .. -R

DJV=`ls eggs | grep Django`
ADMIN_MEDIA=`pwd`'/eggs/'$DJV'/django/contrib/admin/media/'
# Setup apache
a2dissite default
echo '<VirtualHost *:80>' > /etc/apache2/sites-available/chishop
echo '    ServerName chishop.apps-system.com' >> /etc/apache2/sites-available/chishop
echo '    Alias /admin-media/' $ADMIN_MEDIA >> /etc/apache2/sites-available/chishop
echo '    ServerAlias chishop' >> /etc/apache2/sites-available/chishop
echo '    WSGIDaemonProcess chishop processes=1 threads=5 display-name=%{GROUP}' >> /etc/apache2/sites-available/chishop
echo '    WSGIProcessGroup chishop' >> /etc/apache2/sites-available/chishop
echo '    #WSGIPassAuthorization makes apache pass auth headers, this is needed in order to register eggs with Chishop' >> /etc/apache2/sites-available/chishop
echo '    WSGIPassAuthorization On' >> /etc/apache2/sites-available/chishop
echo '    WSGIScriptAlias / '`pwd`'/bin/django.wsgi' >> /etc/apache2/sites-available/chishop
echo '    LogLevel debug' >> /etc/apache2/sites-available/chishop
echo '    ErrorLog /root/error.log' >> /etc/apache2/sites-available/chishop
echo '    CustomLog /root/custom.log combined' >> /etc/apache2/sites-available/chishop
echo '</VirtualHost>' >> /etc/apache2/sites-available/chishop
a2ensite chishop
apache2ctl graceful