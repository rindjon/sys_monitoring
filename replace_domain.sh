#!/bin/bash

# Define the source file that contains the domain name
DOMAIN_FILE="/etc/domain_name"

# Check if the domain file exists
if [[ ! -f "$DOMAIN_FILE" ]]; then
  echo "Error: $DOMAIN_FILE does not exist."
  exit 1
fi

# Read the domain name from the file
DOMAIN_NAME=$(cat "$DOMAIN_FILE")

# Define the target files to modify
GRAFANA_CONFIG="./grafana/config/grafana.ini"
NGINX_CONFIG="./nginx/config/nginx.conf"

# Check if Grafana config file exists
if [[ ! -f "$GRAFANA_CONFIG" ]]; then
  echo "Error: $GRAFANA_CONFIG does not exist."
  exit 1
fi

# Check if Nginx config file exists
if [[ ! -f "$NGINX_CONFIG" ]]; then
  echo "Error: $NGINX_CONFIG does not exist."
  exit 1
fi

# Replace 'public_domain_or_public_ip' with the actual domain name in Grafana config
sed -i "s/public_domain_or_public_ip/$DOMAIN_NAME/g" "$GRAFANA_CONFIG"
echo "Replaced domain in $GRAFANA_CONFIG"

# Replace 'public_domain_or_public_ip' with the actual domain name in Nginx config
sed -i "s/public_domain_or_public_ip/$DOMAIN_NAME/g" "$NGINX_CONFIG"
echo "Replaced domain in $NGINX_CONFIG"

echo "Domain name successfully replaced in both configurations."
