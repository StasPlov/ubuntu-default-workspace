#!/bin/bash

# Обновление списка пакетов
sudo apt-get update

# Установка основных инструментов для разработки, включая 'make'
sudo apt-get install -y build-essential

# Установка PHP (будут установлены обе версии: 7.4 и 8.2)
# Для использования репозиториев с последними версиями PHP
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ondrej/php

# Обновление списка пакетов (сюда добавляются новые из ppa:ondrej/php)
sudo apt-get update

# Установка PHP 7.4 и PHP 8.2 (без Apache2) с необходимыми расширениями
sudo apt-get install -y php7.4-cli php7.4-fpm php7.4-mysql php7.4-curl php7.4-xml
sudo apt-get install -y php8.2-cli php8.2-fpm php8.2-mysql php8.2-curl php8.2-xml

# Установка Nginx
sudo apt-get install -y nginx

# Установка Docker (из официального Docker репозитория для Ubuntu)
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update    # Обновление списка пакетов для добавления репозитория Docker

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER  # Добавление текущего пользователя в группу Docker для выполнения команд без sudo

# Установка Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "if (hash_file('sha384', 'composer-setup.php') === '${HASH}') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

echo 'Перезагрузите сеанс, чтобы применить изменения в группах пользователя.'
