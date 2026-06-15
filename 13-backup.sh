#!/bin/bash

Source=$1
Destination=$2
Days=${3:-7} # Default to 7 days if $3 not provided

#Color 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Usage(){
    echo -e "$R Usage:$N $0 <source-file> <destination-file> <days>"
}

if [ $# -lt 2 ]; then
    Usage
    exit 1
fi

if [ ! -d "$Source" ]
then
    echo -e "$R Error:$N '$Source' does not exist."
    exit 1
fi

mkdir -p "$Destination"

if [ ! -d "$Destination" ]
then
    echo -e "$R Error: '$Destination' does not exist."
    exit 1
fi

Files=$(find "$Source" -name "*.log" -mtime +$Days)
Zip_file="$Destination"/logs-$(date +"%B,%d,%Y-%T").zip

if [ -z "$Files" ] # It will shows the empty files
then 
    echo -e "Files$R doesn't$N exits more than '$Days' in '$Source'"
    exit 1
else
    echo -e "Files are$G exits$N more than '$Days' in '$Source'"
    # echo "$Files"
    echo "$Files" | zip "$Zip_file" -@ 

    echo ""
    if [ -f $Zip_file ]
    then 
        echo -e "Zipping files$G Successfull$N"
        while IFS= read -r gana #IFS, internal field seperator, empty it will ignore while space, -r is for not to ignore special charecters like /
        do
            echo "Deleting file '$gana'"
            rm -rf "$gana"
        done <<< "$Files" 
    else
        echo -e "Zipping files$R Failed$N"
    fi
fi

