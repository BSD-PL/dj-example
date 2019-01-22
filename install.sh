#!/bin/sh

PREFIX="/usr/local"
FILE="$(realpath "${0}")"
HERE="$(dirname "${FILE}")"
PYTHON="python3.6"

mkdir -p "${PREFIX}/etc/nginx"
mkdir -p "${PREFIX}/etc/uwsgi"

ln -fs "${HERE}/etc/nginx.conf" "${PREFIX}/etc/nginx/nginx.conf"
ln -fs "${HERE}/etc/uwsgi.ini"  "${PREFIX}/etc/uwsgi/uwsgi.ini"

sysrc nginx_enable="YES"
sysrc uwsgi_enable="YES"

psql -U postgres -h db < "${HERE}/install.sql"

"${PYTHON}" "${HERE}/setup.py" install
"${PYTHON}" -m example.manage collectstatic --no-input
"${PYTHON}" -m example.manage migrate
