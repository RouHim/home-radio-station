#!/usr/bin/env bash
#
# Entrypoint of the container
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # d
set -e

# Run news.sh
echo "Fetching the latest audio news from Deutschlandfunk..."
./news.sh

# Run the liquidsoap script
echo "Starting the radio stream..."
/app/liquidsoap radio.liq