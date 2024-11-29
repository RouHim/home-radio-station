#!/usr/bin/env bash
#
# Entrypoint of the container
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # d
set -e

# Build pls file
./build-pls.sh music/ music.pls
./build-pls.sh jingles/ jingles.pls

# Run the liquidsoap script
eval "$(opam env)"
liquidsoap radio.liq