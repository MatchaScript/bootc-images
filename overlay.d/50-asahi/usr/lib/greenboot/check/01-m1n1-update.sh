#!/bin/bash
set -euo pipefail

NEW_M1N1="/usr/share/m1n1/universal-boot.bin"
ESP_M1N1="/boot/efi/m1n1/boot.bin"

if [ ! -f "$NEW_M1N1" ]; then
    echo "No new m1n1 found at $NEW_M1N1. Skipping update check."
    exit 0
fi

if [ ! -f "$ESP_M1N1" ]; then
    echo "Current m1n1 not found at $ESP_M1N1. Skipping update check."
    exit 0
fi

if ! cmp -s "$NEW_M1N1" "$ESP_M1N1"; then
    echo "Difference found in m1n1. Updating..."
    cp "$NEW_M1N1" "$ESP_M1N1"
    sync
    echo "m1n1 updated. Rebooting the system to apply changes..."
    systemctl reboot
    exit 0
fi

echo "m1n1 is up to date."
exit 0
