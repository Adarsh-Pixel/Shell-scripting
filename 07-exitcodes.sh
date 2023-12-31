#!/bin/bash

# In Linux each and every action will have a exit code 
#0-255 is the range of codes
# among all 0, represents action completed successfully
#Anything in between 1 to 255 represents either partial success, partial failure or complete failure

# 0         : Global success
# 1-125     : some failure from the command
# 125+      : system failure

# Exit codes play a key role in debugging big scripts