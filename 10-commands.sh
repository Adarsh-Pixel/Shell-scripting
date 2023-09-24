#!/bin/bash

# There are four types of commands available: 

# Binary (#bin ...../sbin)
# aliases
# Shell built-in commands
# Funtions

# To declar a funtion

stat() {
    echo "Number of sessions opened are $(who | wc -l)"
    echo "today's date is $(date +%F)"
}
stat

sleep 1

stat

sleep 2

stat

sleep 3

stat