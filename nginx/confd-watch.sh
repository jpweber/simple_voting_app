#!/bin/sh

set -eo pipefail

export CONSUL_PORT=${CONSUL_PORT:-8500}
export HOST_IP=`ip route | grep default | awk '{print $3}'`
export CONSUL=$HOST_IP:$CONSUL_PORT

echo "[nginx] booting container"

# Put a continual polling `confd` process into the background to watch
# for changes every 10 seconds
confd -interval 10 -backend consul -node $CONSUL &
echo "[nginx] confd is now monitoring consul for changes..."

# Start the Nginx service using the generated config
echo "[nginx] starting nginx service..."
/usr/sbin/nginx 

# Follow the logs to allow the script to continue running
tail -f /var/log/nginx/*.log
