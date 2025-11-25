#!/usr/bin/env bash

choice=$(printf "Logout\nReboot\nShutdown\nCancel" | rofi -dmenu -i -p "Power")

case "$choice" in
  Logout) hyprctl dispatch exit ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
  *) exit 0 ;;
esac
