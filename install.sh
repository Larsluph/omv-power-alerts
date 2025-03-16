#!/bin/bash

# Ensure root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Check git presence
if ! [ -x "$(command -v git)" ]; then
  echo "Git is not installed. Please install git and try again."
  exit 1
fi

mkdir -p /tmp/omv-power-alerts
cd /tmp/omv-power-alerts

# Download the repository
git clone https://github.com/Larsluph/omv-power-alerts.git

# Change directory to the repository
cd omv-power-alerts

TARGET_DIR="/etc/systemd/system"

# Create target directory if it does not exist
if [ ! -d "$TARGET_DIR" ]; then
  mkdir -p "$TARGET_DIR"
fi

# Copy files
cp .env.dist "$TARGET_DIR/omv-power-alerts.d/.env"
cp main.sh "$TARGET_DIR/omv-power-alerts.d/omv-power-alerts"
chmod +x "$TARGET_DIR/omv-power-alerts.d/omv-power-alerts"

for file in ./linux_services/*.service; do
  cp "$file" "$TARGET_DIR"
done

for file in ./linux_services/*.timer; do
  cp "$file" "$TARGET_DIR"
done

cp "./linux_services/wake_detect.sh" "$TARGET_DIR/omv-power-alerts.d/wake_detect.sh"

chmod +x "$TARGET_DIR/omv-power-alerts.d/wake_detect.sh"

# Reload systemd manager configuration
systemctl daemon-reload

# Enable and start services
systemctl enable omv-power-alerts-hibernate.service
systemctl enable omv-power-alerts-poweroff.service
systemctl enable omv-power-alerts-poweron.service
systemctl enable omv-power-alerts-reboot.service
systemctl enable omv-power-alerts-sleep.service
systemctl enable omv-power-alerts-wake.timer
systemctl start omv-power-alerts-wake.timer

# Cleanup
cd ..
rm -rf omv-power-alerts

echo "All services have been moved and activated."
echo "Don't forget to edit the configuration file at $TARGET_DIR/omv-power-alerts.d/.env"
