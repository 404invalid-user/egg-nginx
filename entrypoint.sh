#!/bin/bash
sleep 1
cd /home/container

MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

eval ${MODIFIED_STARTUP}

rm -rf /home/container/tmp/*; 

echo "Starting PHP-FPM";
/usr/sbin/php-fpm --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize;

echo "Starting Nginx";

/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/;

echo "Successfully started";