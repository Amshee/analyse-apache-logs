#!/usr/bin/env bash
if [ -z "$1" ]
  then
    echo "No log filename provided."
    exit 1
fi

result=$(awk '/GET \/production\/file_metadata\/modules\/ssh\/sshd_config/ {print $9}' $1 | wc -l)
echo "/production/file_metadata/modules/ssh/sshd_config fetches: $result"

result=$(awk '/GET \/production\/file_metadata\/modules\/ssh\/sshd_config/ {if (!($9==200)) print $9}' $1 | wc -l)
echo "out of which were not 200: $result"

result=$(awk '{if (!($9==200)) print $9}' $1 | wc -l)
echo "For all logs, count of non 200 result codes: $result"

result=$(awk '/PUT \/dev\/report\// {print $1}'  $1 | wc -l)
echo "PUT requests to path /dev/report/: $result"

result=$(awk '/PUT \/dev\/report\// {print $1}'  puppet_access_ssl.log | awk 'match($0,"[0-9]+.[0-9]+.[0-9]+.[0-9]+")' | wc -l)
echo "out of which were made by IP address: $result"

