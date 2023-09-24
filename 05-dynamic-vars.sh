#!/bin/bash


DATE="$(date +%F)"
SESSIONS_COUNT=$(who | wc -l)

echo -e "\e[32 Today's date is $DATE \e[0m"
echo "total number of action sessions $SESSIONS_COUNT"