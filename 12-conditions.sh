#!/bin/bash

# Conditions helps us to execute something only if SOME-factor is true & if that factor is false then that something won't be execurted

#Syntax of case
# case $var in
#     opt1) commands-x ;;
#     opt2) commands-y ;;
# esac

Action=$1

case $Action in
    start)
        echo -e "\e[32m Starting payment Service \e[0m"
        exit 0
        ;;
    stop)
        echo -e "\e[31mStopping Payment Service \e[0m"
        exit 1
        ;;
    restart)
        echo -e "\e[33mRestarting Payment Service \e[0m"
        exit 2
        ;;
    *)
        echo -e "\e[33mValid options are start or stop or restart \e{0m"
        echo -e "example usage: \n \tbash Scriptname stop"
        exit 3
        ;;
esac