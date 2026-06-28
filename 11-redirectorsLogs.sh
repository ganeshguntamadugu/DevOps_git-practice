#!/bin/bash

#Functions
Logfile_Setup(){
    Log_folder=/var/log/shellscript-practice
    Script_name=$(echo $0 | cut -d "." -f1)
    Log_file=$Log_folder/$Script_name-$(date +"%B,%d,%Y-%T").log
    mkdir -p $Log_folder
}


 #Color 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


ROOT_ACCESS(){
    USERID=$(id -u) #To check the current user

    if [ $USERID -ne 0 ]
    then 
        echo "Get the root access"
        exit 1  
    fi
}


VALIDATE(){    
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 is$R NOT$N installed, going to install" | tee -a $Log_file
        dnf install $2 -y &>>$Log_file
        if [ $? -ne 0 ]
        then
            echo -e "$2 is $R not$N installed, check the error" | tee -a $Log_file
            exit 1
        else
            echo -e "$2 installation is$G Successful$N" | tee -a $Log_file
        fi
    else
        echo -e "$2 is$Y Already$N installed, nothing to do" | tee -a $Log_file
    fi
}


INPUT(){
    if [ $# -eq 0 ]
    then
        echo "Please give any packages names to intall it"
        exit 1
    fi
}


#The main script runs from here

ROOT_ACCESS

Logfile_Setup

INPUT $@

echo "Script started executing at $(date)" | tee -a $Log_file


#Using loops
for package in $@ # $@ refers to all arguments passed to it
do
    echo "" | tee -a $Log_file
    echo "Proceeding to install your requested Package $package" | tee -a $Log_file
    dnf list installed $package &>>$Log_file
    VALIDATE $? $package
done

echo "" | tee -a $Log_file
echo "Script completed executing at $(date)" | tee -a $Log_file