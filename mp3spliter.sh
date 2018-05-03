#!/bin/bash

#mp3spliter using mp3splt

echo -n "Enter the last file of the sequence > "
read filename
echo "confirm: $filename"

mp3splt -a -t 5.50 -o ${filename}-@n -d ${filename} ${filename}.mp3
