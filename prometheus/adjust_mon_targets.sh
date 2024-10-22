#!/bin/bash

# Input file containing IP addresses
input_file="/etc/mon_target_inst_ip"

# Output file (Prometheus configuration file)
output_file="/home/ec2-user/sys_monitoring/prometheus/config/prometheus.yml"

# Check if input file exists
if [ ! -f "$input_file" ]; then
  echo "Input file $input_file not found!"
  exit 1
fi

# Start the job configuration
# echo "  - job_name: 'node-exporter'" >> "$output_file"
echo "  - job_name: 'stock_prediction'" >> "$output_file"
echo "    static_configs:" >> "$output_file"
echo -n "      - targets: [" >> "$output_file"

# Read each line from the input file
while IFS= read -r ip; do
  # Check if the line contains a valid IP address
  if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    # Append the IP address with port 9100 to the Prometheus config
    echo -n "'$ip:8000'," >> "$output_file"
    # echo -n "'$ip:9100'," >> "$output_file"
  else
    echo "Skipping invalid IP: $ip"
  fi
done < "$input_file"

# Remove the last comma and close the target array
sed -i '$ s/,$//' "$output_file"
echo "]" >> "$output_file"

echo "Prometheus configuration updated successfully!"
