#!/bin/bash


DATE="$(date +%F)"
SESSIONS_COUNT=$(who | wc -l)

echo "Today's date is $DATE"
echo "total number of action sessions $SESSIONS_COUNT"