#!/bin/bash
#
# Description:
#     This script tests the container image.
#
# Example usage:
#     ./test-image.sh
#
##################

# Spin up a BeamMP server
echo "🚀 Spinning up a test container"
docker run -d --name test-container rouhim/rsas

# Loop until the string is found
echo "🔍 Checking for the desired string in the logs..."
EXPECTED_STRING="Running with 20 worker threads."
while true; do
  # Check if the desired string is in the logs
  if docker logs test-container | grep -q "$EXPECTED_STRING"; then
    echo "✅ Server started successfully"
    break
  fi

  echo "📃 Desired string not found in the logs, printing the last 5 lines of the logs:"
  echo "========================================"
  docker logs test-container --tail 5
  echo "========================================"

  echo "⏳ Waiting for 1 seconds before checking again..."
  sleep 1
done

# Cleanup and exit with 0
docker kill test-container && docker rm test-container
echo "✅ Done, everything looks good"
exit 0
