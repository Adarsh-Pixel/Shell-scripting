# Bash-scripting

***
This repository contains all the basics needed to learn bash scripting. The major goal is to automate the entire configuration management procedure involved as a part of the set-up.
***

### How to push the code to git hub ?

***
    $ git add .                          // This will let git know to start tracking all the files
    $ git commit -m "updated the readMe file"
    $ git push                           // This will push the code to the repository on GitHub
***

## How to open folder on VSCode with a command

...
    $ code folderName
...


### Expressions are categorized into three

    1. Numbers
    2. Strings
    3. Files

Operators on numbers:

    -eq , -ne , -gt, -ge, -lt, -le

    [ 1 -eq 1 ]
    [ 1 -ne 1 ]

Operators on Strings:
    = , == , !=

    [ abc = abc ]

    -z , -n

    [ -z "$var" ] -> This is true if var is not having any data
    [ -n "$var" ] -> This is true if var is having any data

    -z and -n are inverse propotional options




    #In Bash scripting, even if the instruction x-fails, it just goes with the execution of other commands in sequence. 
    #That's the default behavior of BASH.
    # If you don't want the script to proceed further in case of any failure, you can use "set -e" in the begining of the script.