#!/bin/bash

# Conditions helps us to execute something only if SOME-factor is true & if that factor is false then that something won't be execurted

#Syntax of case
# case $var in
#     opt1) commands-x ;;
#     opt2) commands-y ;;
# esac

Action=start

case $Action in
    start)
        echo "Starting payment Service"
        ;;
    stop)
        echo "Stopping Payment Service"
        ;;
    restart)
        echo "Restarting Payment Service"
        ;;
esac