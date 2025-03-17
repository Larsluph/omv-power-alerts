#!/bin/bash

# Ensure correct usage
if [ "$#" -ne 2 ]; then
  echo "Invalid syntax"
  echo "Syntax: ./omv_power_alerts ALERT_NAME ENV_PATH"
  exit 1
fi

ALERT_NAME=$1
ENV_PATH=$2

# Load environment variables
if [ -f "$ENV_PATH" ]; then
  set -o allexport
  source "$ENV_PATH"
  set -o allexport
else
  echo "error loading env file"
  exit 1
fi

# Function to send webhook
send_webhook() {
  local PAYLOAD=$1
  local WEBHOOK_URL="https://discord.com/api/webhooks/$WEBHOOK_ID/$WEBHOOK_TOKEN"
  curl -X POST -H "Content-Type: application/json" -d "$PAYLOAD" "$WEBHOOK_URL"
}

# Function to generate embed payloads
generate_embed() {
  local TITLE=$1
  local COLOR=$2
  local DATETIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  echo '{"content": "","embeds": [{"title": "'"$TITLE"'","color": '$COLOR',"timestamp": "'"$DATETIME"'"}]}'
}

# Determine the alert type and generate corresponding payload
case "$ALERT_NAME" in
  "poweron")
    PAYLOAD=$(generate_embed "Power ON Event triggered" $((0x13B10B)))
    ;;
  "poweroff")
    PAYLOAD=$(generate_embed "Power OFF Event triggered" $((0xBA0808)))
    ;;
  "sleep")
    PAYLOAD=$(generate_embed "Sleep Event triggered" $((0xCBA20C)))
    ;;
  "wake")
    PAYLOAD=$(generate_embed "Wake Event triggered" $((0x35b7e0)))
    ;;
  "reboot")
    PAYLOAD=$(generate_embed "Reboot Event triggered" $((0x0C4CCB)))
    ;;
  *)
    PAYLOAD=$(generate_embed "Unknown Event triggered" $((0xFFFFFF)))
    ;;
esac

# Send the webhook
send_webhook "$PAYLOAD"
