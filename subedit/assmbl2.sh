#!/bin/bash

## read in the last srt file of the sequence ##
## must be name-dd.srt
echo -n "Enter the last file of the sequence > "
read filename
echo "confirm: $filename"
#echo "$1"   # not used

## split the file name##

#regex to split file name
# regex="([0-9])([0-9]).srt"  # first
regex="(.+)-([0-9][0-9]).srt"
dash="-"
audiotype=".mp3"
captype=".srt"
j="j"


##    echo filename =~ *[0-9,0-9]*.srt
#[$filename =~ $regex]
#maxfile="${BASH_REMATCH[1]}"
#echo $maxfile

f=$filename


    if [[ $f =~ $regex ]]
    then
        fname="${BASH_REMATCH[1]}"
        fnum="${BASH_REMATCH[2]}"
 #       name3="${BASH_REMATCH[3]}" # not used
        echo "$fname"
        echo "$fnum"
        echo "$name3"
        
        echo "${name}.jpg"    # concatenate strings
        name="${name}.jpg"    # same thing stored in a variable
    else
        echo "$f doesn't match" >&2 # this could get noisy if there are a lot of non-matching files
    fi


######    cp file-01.srt out.srt


for ((i = 2; i < $((fnum)) + 1; i++))
do
		
		if [ "$i" -lt 10 ]
			then
				echo "in if"
				ichar="0"$i
				#ichar="0"+$i
			else
				ichar=$i
		fi
				
	
		srtfile=$fname$dash$ichar$captype
		audiofile=$fname$dash$ichar$audiotype
		echo $audiofile
		echo $srtfile
		
		
		jsrtfile=$j$fname$dash$ichar$captype
		cp "$srtfile" "$jsrtfile"
		
		echo $jsrtfile
		
	### original	ffprobe -i bettina--01.mp3  -v quiet -show_format -sexagesimal | sed -n 's/duration=//p';
		
#		hms= "ffprobe -i "$audiofile"#  -v quiet -show_format -sexagesimal" # | "sed -n 's/duration=//p'"
		hms=$(ffprobe -i $audiofile  -v quiet -show_format -sexagesimal | sed -n 's/duration=//p')
####	/home/marcwe/subedit/subedit -i file name -s +hms
###	cat file >> out.srt

	echo $hms
	echo $i
done

