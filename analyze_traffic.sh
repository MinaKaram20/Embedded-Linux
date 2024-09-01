#!/usr/bin/bash

# Bash Script to Analyze Network Traffic


# Input: Path to the Wireshark pcap file

pcap_file=$1 # capture input from terminal.


# Function to extract information from the pcap file

analyze_traffic() {

  # Use tshark or similar commands for packet analysis.

  # Hint: Consider commands to count total packets, filter by protocols (HTTP, HTTPS/TLS),
  Total_packets=$(tshark -r "$pcap_file" | wc -l) #Read the file and then counts the lines as each line represent a Packet

  http_count=$(tshark -r "$pcap_file" -Y http | wc -l)
  tls_count=$(tshark -r "$pcap_file" -Y tls | wc -l)

  # extract IP addresses, and generate summary statistics.

  # Output analysis summary

  echo "----- Network Traffic Analysis Report -----"

  # Provide summary information based on your analysis

  # Hints: Total packets, protocols, top source, and destination IP addresses.

  echo "1. Total Packets: $Total_packets"

  echo "2. Protocols:"

  echo "  - HTTP: $http_count packets"

  echo "  - HTTPS/TLS: $tls_count packets"

  echo ""

  echo "3. Top 5 Source IP Addresses:"

  # Provide the top source IP addresses

  tshark -r "$pcap_file" -T fields -e ip.src | awk '{count[$1]++} END {for (ip in count) print ip," : ", count[ip], " Packets"}' | sort -t: -k2,2nr | head -n 5

  echo ""

  echo "4. Top 5 Destination IP Addresses:"

  # Provide the top destination IP addresses

  tshark -r "$pcap_file" -T fields -e ip.dst | awk '{count[$1]++} END {for (ip in count) print ip," : ", count[ip], " Packets"}' | sort -t: -k2,2nr | head -n 5

  echo ""

  echo "----- End of Report -----"

}


# Run the analysis function

analyze_traffic