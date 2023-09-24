#!/bin/bash


DATE="$(date +%F)"
SESSIONS_COUNT=$(who | wc -l)

echo -e "Today's date is \e[32m $DATE \e[0m"
echo -e "total number of action sessions \e[32m $SESSIONS_COUNT \e[0m"