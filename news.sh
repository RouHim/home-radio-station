#!/usr/bin/env bash

# TODO: finde und late dynamisch neuste nachrichten runter
# https://ondemand-mp3.dradio.de/file/dradio/2024/11/29/nachrichten_dlf_20241129_1500_c038ae02.mp3

TODAY=$(date +%Y-%m-%d)
QUERY_URL="https://www.deutschlandfunk.de/suche?drsearch:searchText=&drsearch:from-date=$TODAY&drsearch:to-date=$TODAY&drsearch:only-audio=1&drsearch:series=PAPAYA_BROADCAST_169&drsearch:stations=4f8db02a-35ae-4b78-9cd0-86b177726ec0&drsearch:stations-all=56f11dfd-a3a8-429b-acaf-06bf595f2dd8&drsearch:stations-all=64df3047-eea5-411a-877c-c415f344a8e7&drsearch:stations-all=4f8db02a-35ae-4b78-9cd0-86b177726ec0"
