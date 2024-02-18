#!/bin/bash

#export PS4="\$LINENO: "
#set -xv

CURR_DATE=$(date +%s)
DATA_FILE=/etc/systemd/system/omv-power-alerts.d/last_poll_time
POLL_INTERVAL=$((60*15)) # 15 minutes

if [ ! -f "$DATA_FILE" ]; then
  echo "$CURR_DATE" > "$DATA_FILE"
  echo file created
  exit 0
fi

LAST_POLL_TIME=$(cat "$DATA_FILE")
echo "$CURR_DATE" > "$DATA_FILE"

if [[ $LAST_POLL_TIME -le $((CURR_DATE - POLL_INTERVAL)) ]]; then
  /etc/systemd/system/omv-power-alerts.d/omv-power-alerts wake /etc/systemd/system/omv-power-alerts.d/.env
  echo "Wake detected"
  exit 0
fi

echo no action needed
