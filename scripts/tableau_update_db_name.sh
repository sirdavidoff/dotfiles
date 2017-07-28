#!/bin/bash

# Need to pass the Tableau file you're looking to change as an arguement to this script

TODAY=$(date +%Y_%m_%d)
FILE=$(basename "$1")

sed -i '.bak' "s/dbname='pw_analytics_20[0-9_]*'/dbname='pw_analytics_$TODAY'/g" "$1"

echo "Updated $FILE to use pw_analytics_$TODAY"
