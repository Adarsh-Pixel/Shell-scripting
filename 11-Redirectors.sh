#!/bin/bash

#Redirectors are of 2 types in Bash
#Input Redirectors (Means take input from a file)            :  <    (eg: Sudo mysql </tmp/student.sql)
#output Redirectors (Means routing the Output to a file)      : >     (>> appends the latest output to an existing content)

# #Outputs
#     1) Standard Output                      > or >> or 1>
#     2) Standard Error                       2> or 2>>
#     3) Standard Output & Standard Error     &> or &>>


# ls -ltr     > output.txt    #Redirects the output to output.txt
# ls -ltr     >> output.txt   #Redirects & appends the output to output.txt
# ls -ltr     2> output.txt   #Redirects the error only to output.txt
# ls -ltr     &> output.txt   #Redirects the output or error to output.txt

exit 1

echo Hai