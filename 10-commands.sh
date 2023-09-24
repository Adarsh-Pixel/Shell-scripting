#!/bin/bash

# There are four types of commands available: 

# Binary (#bin ...../sbin)
# aliases
# Shell built-in commands
# Funtions

# To declar a funtion
hai() {
    echo I am a Hi function
    echo I am here to tell you Hai
}

stat() {
    echo "Number of sessions opened are $(who | wc -l)"
    echo "today's date is $(date +%F)"
    echo "Avg CPU utilization is last 5 mins $(uptime | awk -F : '{print $NF}')"
    #calling another funtion
    hai
}
stat
