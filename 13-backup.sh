#!/bin/bash

Source=$1
Destination=$2
Days=${3:-7} # Default to 7 days if not provided

#Color 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Usage(){
    echo "Usage: $0 <source-file> <destination-file> [days]"
}

if [ $# -lt 2 ]; then
    Usage
    exit 1
fi

if [ ! -d $Source]
then
    echo -e "$R Error:$N '$Source' does not exist."
    exit 1
else
fi

if [ ! -d $Destination ]
then
    echo -e "$R Error: '$Destination' does not exist."
    exit 1
else
fi