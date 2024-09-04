#!/bin/bash

# Step 1: Get the Configuration of the Wifi
route_output=$(route -n get default)

# Step 2: Parse the IP of the gateway
gateway_ip=$(echo "$route_output" | grep 'gateway' | awk '{print $2}')

# Check if we got a valid gateway IP
if [ -z "$gateway_ip" ]; then
  echo "Error: Could not find gateway IP."
  exit 1
fi

echo "Gateway IP found: $gateway_ip"

# Step 3: Add the gateway IP to the DNS of the Mac
# First, backup existing DNS settings
networksetup -getdnsservers Wi-Fi > /tmp/dns_backup.txt
echo "DNS configuration saved in /tmp/dns_backup.txt"

# Add the gateway IP to DNS
sudo networksetup -setdnsservers Wi-Fi $gateway_ip
echo "DNS set to: $gateway_ip"

# Step 4: Authenticate to the SNCF Wifi
curl_response=$(curl -s -o /dev/null -w "%{http_code}" -X POST 'https://wifi.sncf/router/api/connection/activate/auto')
if [ "$curl_response" -eq 200 ]; then
  echo "************************************"
  echo "***** YOU'RE CONNECTED ! BRAVO *****"
  echo "************************************"
else
  echo "SORRY :( POST request failed with status code: $response"
fi

while true; do
  read -p "Enter any key once you're done to close the connection and cleanup the configuration: " user_input
  if [ ! -z "$user_input" ]; then
    break
  fi
done


# Step 5: Restore previous DNS settings after script runs
dns_backup=$(cat /tmp/dns_backup.txt)
sudo networksetup -setdnsservers Wi-Fi $dns_backup
echo "DNS restored to original settings: $dns_backup"