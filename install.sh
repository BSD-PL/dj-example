#!/bin/sh

PREFIX="/usr/local"
FILE="$(realpath "${0}")"
HERE="$(dirname "${FILE}")"
PYTHON="python3.6"

die() {
	echo "${@}" >&2
	exit 1
}

mkdir -p "${PREFIX}/etc/nginx"
mkdir -p "${PREFIX}/etc/uwsgi"

cp -f "${HERE}/etc/nginx.conf" "${PREFIX}/etc/nginx/nginx.conf"
cp -f "${HERE}/etc/uwsgi.ini"  "${PREFIX}/etc/uwsgi/uwsgi.ini"

sysrc nginx_enable="YES"
sysrc uwsgi_enable="YES"

"${PYTHON}" "${HERE}/setup.py" install || die "Could not install application."
"${PYTHON}" -m example.manage collectstatic --no-input ||
	die "Could not generate static files."
"${PYTHON}" -m example.manage migrate ||
	die "Could not create database schema."
"${PYTHON}" -m example.manage loaddata "${HERE}/fixture.json" ||
	die "Could not populate database."

echo "Installation completed successfully."
