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



    ### How to keep our Roboshop audomation project DRY ? How can we eliminate the repitative code

    1) Best possible approach is define funtions and call them on whenver you need
    2) the caviet, here is by default if you define a funtion inf x.sh, you can only call that funtion in that file only.
    3) To overcome the above challenge, what we can do is, we can define funtions in a common.sh file and call all the needed funtions from the common file.

    ---
        a) For nodejs components, let's create a funtion for nodejs and declare all the action in this and call it when you're using any nodejs components
        b) for python components, let's create a funtion for python and declare all the action in this and call it when you're using any python components
        c) for java components, let's create a funtion for java and declare all the action in this and call it when you're using any java components
        d) For angularjs components, let's create a funtion for angularjs and declare all the action in this and call it when you're using any angularjs components