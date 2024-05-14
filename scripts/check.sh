#!/bin/bash

# Check if version parameter is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

VERSION=$1
CONTAINER_NAME="bitbucket_$VERSION"
LOGFILE="log.txt"

# Start the Atlassian Bitbucket container
docker run -d --name $CONTAINER_NAME -p 7990:7990 atlassian/bitbucket:$VERSION >> $LOGFILE 2>&1

# Function to check if the service is ready
check_service_ready() {
  local response=$(curl -s http://localhost:7990/status)
  echo "$response" | grep -q '{"state":"FIRST_RUN"}'
}

{
  echo "Waiting for Bitbucket service to be ready..."
  until check_service_ready; do
    echo -n "."
    sleep 5
  done
  echo "Bitbucket service is ready."

  # Query the specified endpoints and log the HTTP response status codes
  RESPONSE_CODE_1=$(curl -o /dev/null -s -w "%{http_code}\n" "http://localhost:7990/plugins/servlet/oauth2/consent?redirect_uri=https://x.cloud/")
  RESPONSE_CODE_2=$(curl -o /dev/null -s -w "%{http_code}\n" "http://localhost:7990/plugins/servlet/oauth2/consent?redirect_uri=https://x.com/")
  
  echo "HTTP response status code for /plugins/servlet/oauth2/consent?redirect_uri=https://x.cloud/: $RESPONSE_CODE_1"
  echo "HTTP response status code for /plugins/servlet/oauth2/consent?redirect_uri=https://x.com/: $RESPONSE_CODE_2"

  # Stop and remove the container
  echo "Stopping and removing the container..."
  docker stop $CONTAINER_NAME >> $LOGFILE 2>&1
  docker rm $CONTAINER_NAME >> $LOGFILE 2>&1
} >> $LOGFILE 2>&1

# Compare the response codes and print the appropriate message
if [ "$RESPONSE_CODE_1" -eq "$RESPONSE_CODE_2" ]; then
  echo "Bug Absent: $RESPONSE_CODE_1"
else
  echo "Bug found: $RESPONSE_CODE_1 and $RESPONSE_CODE_2"
fi
