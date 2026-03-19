#!/bin/sh
# wifi-init.sh - Wi-Fi init script with TOML config
# AP mode is default, STA only if mode=sta
# Place in /usr/bin, chmod +x

CONFIG_FILE=/etc/aa-mirror-rs/config.toml
WLAN_IF=wlan0

# --- Parse TOML ---
AA_MODE=$(sed -n 's/^[[:space:]]*aa_mode[[:space:]]*=[[:space:]]*"\([^"]*\)".*/\1/p' "$CONFIG_FILE")

# --- Bring interface up ---
ip link set "$WLAN_IF" up
sleep 1  # allow driver to initialize

# --- Decide mode ---
if [ "$AA_MODE" = "Mirror" ]; then
    echo "Starting Wi-Fi in STA mode"
    
    # Disable power save
    iw "$WLAN_IF" set power_save off

    # Set hostname
    HOSTNAME=$(cat /etc/hostname 2>/dev/null || echo "aa-mirror")
    hostname "$HOSTNAME"
    
    # Start wpa_supplicant with static config
    wpa_supplicant -B -D nl80211 -i "$WLAN_IF" -c /etc/wpa_supplicant.conf

    # Get DHCP
    udhcpc -i "$WLAN_IF" -q

else
    echo "Starting Wi-Fi in default AP mode"

    # Disable power save
    iw "$WLAN_IF" set power_save off

    # Start hostapd with logging
    hostapd -B /var/run/hostapd.conf -t -f /var/log/hostapd

    # Optional: start DHCP server if dnsmasq is used
    if [ -f /etc/dnsmasq.conf ]; then
        dnsmasq -C /etc/dnsmasq.conf
    fi
fi
