#!/usr/bin/env bash

# Install and start systemd starcorn service
# If the server is binded to a Unix domain socket (--uds), the service will be started with user=www-data

USAGE_STR="Usage: sudo ./install_service.sh staticdir [UVICORN_OPTIONS: --host, --port, etc.]"
# requires superuser privileges

SERVICE_FILE="/etc/systemd/system/starcorn.service"

if [ "$#" -lt 1 ]; then
    echo "$USAGE_STR"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "First argument must be a static files directory"
    echo "$USAGE_STR"
    exit 1
fi

usergroup=""
for arg; do
    if [ "$arg" = "--uds" ]; then
        usergroup="User=www-data
Group=www-data"
    fi
done

set -e

starcorndir=$( cd -- $( dirname -- "$0") && pwd )

touch "$SERVICE_FILE"
cat << EOF > "$SERVICE_FILE"
[Unit]
Description=Starcorn web server
After=network.target

[Service]
Type=exec
WorkingDirectory=$starcorndir
ExecStart=$starcorndir/starcorn.py $@
$usergroup

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable starcorn
systemctl restart starcorn
