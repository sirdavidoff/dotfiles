#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
  echo $(networksetup -getdnsservers Wi-Fi)
  exit
else
  if [[ $1 = "fra" ]]; then
    IP=54.93.169.181
  elif [[ $1 = "cop" ]]; then
    IP=82.103.129.240
  elif [[ $1 = "clear" ]]; then
    networksetup -setdnsservers Wi-Fi Empty
    echo "Servers cleared"
    exit
  else
    echo "Command not recognised"
    exit
  fi

  # Set the DNS servers
  networksetup -setdnsservers Wi-Fi $IP
  echo "Set to $(networksetup -getdnsservers Wi-Fi)"
fi

