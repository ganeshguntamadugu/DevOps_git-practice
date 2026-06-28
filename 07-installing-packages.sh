#!/bin/bash

#Installing git
USERID=$(id -u) #To check the current user

if [ $USERID -ne 0 ]
then 
    echo "Get the root access"
    exit 1
else 
    echo "Proceeding to install your requested Package Git"
fi

#Check if git installed already or not
dnf list installed git

if [ $? -ne 0 ]
then
    echo "Git is not installed, going to install"
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "Git is not install, Please check the error"
        exit 1
    else 
        echo "Git is installed successfully"
    fi
else
    echo "Git is already installed, nothing to do"
fi

#Installing mysql
USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Get the root access"
    exit 1
else
    echo "Proceeding to install your requested Package MySQL" 
fi

#checking status of msql Package

dnf list installed mysql
if [ $? -ne 0 ]
then 
    echo "MySQL is not installed, going to install"
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "MySQL is not install, check the error"
        exit 1
    else
        echo "MySQL installation is Successful"
    fi
else
    echo "MySQL is already installed, nothing to do"
fi

# else
#     echo "MySQL is aleady installed, I'm deleting it and reinstalling it"
#     dnf remove mysql -y
#     if [ $? -eq 0 ]
#     then
#         echo "MySQL is removed"
#     fi
#     dnf install mysql -y
#     if [ $? -ne 0 ]
#     then
#         echo "MySQL is not install, check the error"
#         exit 1
#     else
#         echo "MySQL reinstalled Successfully"
#     fi
# fi