#!/bin/bash

for ((i = 2; i < 20; i++))
do
		
		if [ "$i" -lt "10" ]
			then
				echo "in if"
				ichar="0"$i
				ichar1="0"+{$i}
			else
				ichar=$i
		fi
				
	
	echo $ichar
	echo $ichar1
	echo $i
done
