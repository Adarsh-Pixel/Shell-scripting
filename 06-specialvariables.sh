#!/bin/bash

a=10
b=20
c=30

echo "the value of a is $a"
echo "the value of b is $b"
echo "the value of c is $c"

echo $0
# special variables gives special properties to your variables

echo "Name of the recently launched rocket in India is $1"
echo "The expensive car in India is $2"
echo "The fastest runner in the world is $3"

echo $*
echo $@
echo $$
echo $#
echo $?