#!/bin/bash
echo '$*'
echo '$@'
echo '$$'
echo '$#'
echo '$?'

# Single quotes will supress the power of special variables
# whenever we have special variables prefer double quotes