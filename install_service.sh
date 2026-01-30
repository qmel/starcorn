#!/usr/bin/env bash

USAGE_STR="Usage: ./install_service.sh staticdir [UVICORN_OPTIONS: --host, --port, etc.]"
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

set -e

starcorndir=$( cd -- $( dirname -- "$0") && pwd )

touch "$SERVICE_FILE"
cat << EOF > "$SERVICE_FILE"
[Unit]
Description=Starcorn web server

[Service]
Type=simple
WorkingDirectory=$starcorndir
ExecStart=$starcorndir/starcorn.py $@
EOF

systemctl daemon-reload
systemctl restart starcorn
