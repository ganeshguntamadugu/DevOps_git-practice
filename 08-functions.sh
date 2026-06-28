#!/bin/bash

#Color 
R="\e[31m"
G="\e[32m"
N="\e[0m"

#Functions

ROOT_ACCESS(){
    USERID=$(id -u) #To check the current user

    if [ $USERID -ne 0 ]
    then 
        echo "Get the root access"
        exit 1
    else 
        echo "Proceeding to install your requested Package $1"
    fi
}

VALIDATE(){    
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 is $R NOT $N installed, going to install"
        dnf install $3 -y
        if [ $? -ne 0 ]
        then
            echo "$2 is not install, check the error"
            exit 1
        else
            echo -e "$2 installation is $G Successful $N"
        fi
    else
        echo -e "$2 is $G Already $N installed, nothing to do"
    fi
}

ROOT_ACCESS Git
dnf list installed git
VALIDATE $? Git git

ROOT_ACCESS MySQL
dnf list installed mysql
VALIDATE $? MySQL mysql

ROOT_ACCESS Nginx
dnf list installed nginx
VALIDATE $? Nginx nginx

