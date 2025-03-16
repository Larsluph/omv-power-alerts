rm -rf /etc/systemd/system/omv-power-alerts.d

systemctl disable omv-power-alerts-hibernate.service
systemctl disable omv-power-alerts-poweroff.service
systemctl disable omv-power-alerts-poweron.service
systemctl disable omv-power-alerts-reboot.service
systemctl disable omv-power-alerts-sleep.service
systemctl disable omv-power-alerts-wake.timer
systemctl stop omv-power-alerts-wake.timer
systemctl daemon-reload

rm /etc/systemd/system/omv-power-alerts-hibernate.service
rm /etc/systemd/system/omv-power-alerts-poweroff.service
rm /etc/systemd/system/omv-power-alerts-poweron.service
rm /etc/systemd/system/omv-power-alerts-reboot.service
rm /etc/systemd/system/omv-power-alerts-sleep.service
rm /etc/systemd/system/omv-power-alerts-wake.service
rm /etc/systemd/system/omv-power-alerts-wake.timer
