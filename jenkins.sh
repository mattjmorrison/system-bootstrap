
# Tested with Ubuntu 10.10 (Maverick Meerkat)

# Add the jenkins repository to the package manager
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
sudo aptitude update

# Install Jenkins
sudo aptitude install jenkins -y
# Install Apache
sudo aptitude install apache2 -y

# Setup apache to be a proxy for Jenkins
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod vhost_alias
sudo a2dissite default

# Create a vhost for jenkins to proxy to port 8080
sudo echo '<VirtualHost *:80>' > /etc/apache2/sites-available/jenkins
sudo echo '    ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/jenkins
sudo echo '    ServerName ci.company.com' >> /etc/apache2/sites-available/jenkins
sudo echo '    ServerAlias ci' >> /etc/apache2/sites-available/jenkins
sudo echo '    ProxyRequests Off' >> /etc/apache2/sites-available/jenkins
sudo echo '    <Proxy *>' >> /etc/apache2/sites-available/jenkins
sudo echo '        Order deny,allow' >> /etc/apache2/sites-available/jenkins
sudo echo '        Allow from all' >> /etc/apache2/sites-available/jenkins
sudo echo '    </Proxy>' >> /etc/apache2/sites-available/jenkins
sudo echo '    ProxyPreserveHost on' >> /etc/apache2/sites-available/jenkins
sudo echo '    ProxyPass / http://localhost:8080/' >> /etc/apache2/sites-available/jenkins
sudo echo '</VirtualHost>' >> /etc/apache2/sites-available/jenkins

# Enable the Jenkins vhost
sudo a2ensite jenkins

# Restart apache
sudo apache2ctl restart
