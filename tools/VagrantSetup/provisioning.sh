#!/usr/bin/env bash

apt-get update
apt-get install -y apache2 cpanminus make imagemagick perlmagick unar redis-server npm git

ln -s /usr/bin/nodejs /usr/bin/node

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

rm -rf /var/www/lanraragi
git clone https://github.com/Difegue/LANraragi.git /var/www/lanraragi
cd /var/www/lanraragi

cpanm CGI Template Redis JSON::Parse CGI::Session File::ShareDir::Install CGI::Session::Driver::redis Image::Info IPC::Cmd LWP::Simple LWP::Protocol::https Digest::SHA URI::Escape Authen::Passphrase Switch
npm install

cp /vagrant/000-default.conf /etc/apache2/sites-enabled/000-default.conf

a2enmod cgi
service apache2 restart

chown -R www-data /var/www/lanraragi
chmod -R 755 /var/www/lanraragi

rm -r /var/www/lanraragi/.git
rm -r /var/www/lanraragi/tools