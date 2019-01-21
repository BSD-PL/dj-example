#!/bin/sh

PREFIX="/usr/local"
FILE="$(realpath "${0}")"
HERE="$(dirname "${FILE}")"

#python setup.py install
mkdir -p "${PREFIX}/etc/nginx"
mkdir -p "${PREFIX}/etc/uwsgi"

ln -fs "${HERE}/etc/nginx.conf" "${PREFIX}/etc/nginx/nginx.conf"
ln -fs "${HERE}/etc/uwsgi.ini"  "${PREFIX}/etc/uwsgi/uwsgi.ini"

sysrc nginx_enable="YES"
sysrc uwsgi_enable="YES"

su -l postgres psql < "${HERE}/install.sql"
