#!/bin/bash

repository="atlassian/bitbucket"
url="https://registry.hub.docker.com/v2/repositories/${repository}/tags"
tags=()

while [ -n "$url" ]; do
  response=$(curl -s "$url")
  tags+=($(echo "$response" | jq -r '.results[].name'))
  url=$(echo "$response" | jq -r '.next')
done

echo "Available tags for ${repository}:"
for tag in "${tags[@]}"; do
  echo "$tag"
done
