#!/bin/bash

## This is a typical virtual host configuration.

readonly SERVICE_DOMAIN="project.domain"
readonly SERVICE_PATH="/home/project"




SERVICE_PATH_=$(echo "${SERVICE_PATH}" | sed  's/\/$//')

conf=$(cat <<'EOS'
<VirtualHost *:80>
        ServerName ${SERVICE_DOMAIN}
        ServerAlias www.${SERVICE_DOMAIN}

        DocumentRoot "${SERVICE_PATH_}"
        LogLevel debug
        ErrorLog "\${APACHE_LOG_DIR}/${SERVICE_DOMAIN}-error.log"
        CustomLog "\${APACHE_LOG_DIR}/${SERVICE_DOMAIN}-access.log" common

        Options Indexes FollowSymLinks

        <Directory />
                Require all granted
                RewriteEngine On
                LogLevel alert rewrite:trace3
                RewriteCond %{REQUEST_FILENAME} !-f
                RewriteRule ^ index.php [QSA,L]
        </Directory>
</VirtualHost>
<Directory ${SERVICE_PATH_}>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
EOS
)

eval "c=\"${conf}\""
echo "${c}"

