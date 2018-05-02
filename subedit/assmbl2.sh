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
audiotype=".m4a"
captype=".srt"
j="j"
#let "totalsec=0"


convertAndPrintSeconds() {
 
    local totalSeconds=$1;
    local seconds=$((totalSeconds%60));
    local minutes=$((totalSeconds/60%60));
    local hours=$((totalSeconds/60/60%24));
    local days=$((totalSeconds/60/60/24));
    (( $days > 0 )) && printf '%d days ' $days;
    (( $hours > 0 )) && printf '%d hours ' $hours;
    (( $minutes > 0 )) && printf '%d minutes ' $minutes;
    (( $days > 0 || $hours > 0 || $minutes > 0 )) && printf 'and ';
    printf '%d seconds\n' $seconds;
}

#function hms(s)
#{
#  h=int(s/3600);
#  s=s-(h*3600);
#  m=int(s/60);
#  s=s-(m*60);
#  printf("%d:%02d:%02d\n", h, m, s);
#}

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

echo "$fname$dash"01"$captype"
cp "$fname$dash"01"$captype" out.srt


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
		let "lastfilecount=i-1"
		echo $lastfilecount " before if"
		
		
		if [ "$((lastfilecount))" -lt 10 ]
			then
				echo "lastfilecount under 10"
				echo $lastfilecount " in if"
				lastfilecountchar="0"$lastfilecount
				echo $lastfilecountchar
			else
				echo "no change of lastfilecount"
		fi
		
		
		

		
		audiofile=$fname$dash$lastfilecountchar$audiotype
		echo $audiofile
		echo $srtfile
		
		
		jsrtfile=$j$fname$dash$ichar$captype
		cp "$srtfile" "$jsrtfile"
		
		echo $jsrtfile
		
	### original	ffprobe -i bettina--01.mp3  -v quiet -show_format -sexagesimal | sed -n 's/duration=//p';
		
		sec=$(ffprobe -i $audiofile  -v quiet -show_format | sed -n 's/duration=//p')
		hms=$(ffprobe -i $audiofile  -v quiet -show_format -sexagesimal | sed -n 's/duration=//p')
		


	echo $sec
	echo $hms
	
	echo $sec | awk {'h=int($0/3600);r=($0-(h*3600));m=int(r/60);s=(r-(m*60)); print h ":" m ":" s'}
	echo $sec | awk {'h=int($0/3600);r=($0-(h*3600));m=int(r/60);s=(r-(m*60)); printf "%02d" ":" "%02d" ":" "%02.3f",h, m, s'}
	convhmsf=$(echo $sec | awk {'h=int($0/3600);r=($0-(h*3600));m=int(r/60);s=(r-(m*60)); printf "%02d" ":" "%02d" ":" "%02.3f",h, m, s'})
	convhms=$(echo $sec | awk {'h=int($0/3600);r=($0-(h*3600));m=int(r/60);s=(r-(m*60)); print h ":" m ":" s'})
	echo $convhms
	echo $convhmsf
	
	totalsec=$(echo | awk "BEGIN {print ($totalsec+$sec)}")
	echo $totalsec
	
	echo $totalsec | awk {'h=int($0/3600);r=($0-(h*3600));m=int(r/60);s=(r-(m*60)); print h ":" m ":" s'}
	echo $totalsec | awk {'h=int($0/3600);r=($0-(h*3600));m=int(r/60);s=(r-(m*60)); printf "%02d" ":" "%02d" ":" "%02.3f",h, m, s'}
	totalconvhmsf=$(echo $totalsec | awk {'h=int($0/3600);r=($0-(h*3600));m=int(r/60);s=(r-(m*60)); printf "%02d" ":" "%02d" ":" "%02.3f",h, m, s'})
	totalconvhms=$(echo $totalsec | awk {'h=int($0/3600);r=($0-(h*3600));m=int(r/60);s=(r-(m*60)); print h ":" m ":" s'})
	echo $totalconvhms
	echo $totalconvhmsf
	totalconvhmsf=$(echo ${totalconvhmsf} | sed 's/\./,/')
	echo $totalconvhmsf
	#$convhms=$(echo ${convhms//
	
#	echo convertAndPrintSeconds(${sec})
#	echo hms($sec)
	echo $i
	
			
	bash /home/marcwe/subedit/subedit -i "$jsrtfile" -s +"$totalconvhmsf"
	cat "$jsrtfile" >> out.srt
	
	
	
done

