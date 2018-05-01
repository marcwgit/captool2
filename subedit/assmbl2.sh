#!/bin/bash

## read in the last srt file of the sequence ##
## must be name-dd.srt
echo -n "Enter the last file of the sequence > "
read filename
echo "confirm: $filename"
#echo "$1"   # not used

## split the file name##

#regex to split file name
regex="([0-9])([0-9]).srt"


##    echo filename =~ *[0-9,0-9]*.srt
#[$filename =~ $regex]
#maxfile="${BASH_REMATCH[1]}"
#echo $maxfile

f=$filename


    if [[ $f =~ $regex ]]
    then
        name1="${BASH_REMATCH[1]}"
        name2="${BASH_REMATCH[2]}"
        echo "$name1"
        echo "$name2"
        
        echo "${name}.jpg"    # concatenate strings
        name="${name}.jpg"    # same thing stored in a variable
    else
        echo "$f doesn't match" >&2 # this could get noisy if there are a lot of non-matching files
    fi

