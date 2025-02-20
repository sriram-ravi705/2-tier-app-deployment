#!/bin/bash
apt update -y
apt install apache2 -y
systemctl enable --now apache2
echo "<h1>$(hostname -I | cut -d' ' -f1)</h1>" > /var/www/html/index.html