#!/usr/bin/env bash
#
# news.sh - Fetches the latest audio news from Deutschlandfunk
#
# This script retrieves the latest audio news broadcast from Deutschlandfunk
# for the current date and saves the URL to a playlist file.
#
# Usage:
#   ./news.sh
#
# Requirements:
#   - curl: Command-line tool for transferring data with URLs
#   - grep: Command-line utility for searching plain-text data
#   - sort: Command-line utility for sorting lines of text files
#   - date: Command-line utility for displaying or setting the date and time
#
# Output:
#   - Prints the latest MP3 URL to the console
#   - Writes the latest MP3 URL to the file 'news.pls'
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
set -e

# Set the date for today
TODAY=$(date +%Y-%m-%d)

# Define the query URL
QUERY_URL="https://www.deutschlandfunk.de/suche?drsearch:searchText=&drsearch:from-date=$TODAY&drsearch:to-date=$TODAY&drsearch:only-audio=1&drsearch:series=PAPAYA_BROADCAST_169&drsearch:stations=4f8db02a-35ae-4b78-9cd0-86b177726ec0&drsearch:stations-all=56f11dfd-a3a8-429b-acaf-06bf595f2dd8&drsearch:stations-all=64df3047-eea5-411a-877c-c415f344a8e7&drsearch:stations-all=4f8db02a-35ae-4b78-9cd0-86b177726ec0"

# Fetch the HTML content from the query URL
HTML_CONTENT=$(curl -s "$QUERY_URL")

# Extract all MP3 URLs from the HTML content
MP3_URLS=$(echo "$HTML_CONTENT" | grep -oP 'https://download\.deutschlandfunk\.de/file/dradio/\d{4}/\d{2}/\d{2}/nachrichten_dlf_\d{8}_\d{4}_[a-f0-9]{8}\.mp3' | sort -u)

# Get the latest (last) URL
LATEST_MP3_URL=$(echo "$MP3_URLS" | tail -n 1)

# Print the latest MP3 URL to the console
echo "$LATEST_MP3_URL"

# Write url to news.pls file
echo "$LATEST_MP3_URL" > news.pls