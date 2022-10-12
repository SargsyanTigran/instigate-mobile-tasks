#!/bin/bash
greatestDivider(){
	red='\033[0;31m'
        white='\033[0m'
	echo "Enter first number:"
	read first
	echo "Enter second number:"
	read second
	if ! [[ $first =~ ^[0-9]+$ ]] || ! [[ $second =~ ^[0-9]+$ ]]
	then
		echo -e "${red}Enter only numbers${white}"
		greatestDivider
		return 0
	fi
	first_array=()
	second_array=()
	third_array=()
	for (( i=1; i<=$first; i++ ))
	do
		if [ $(expr $first % $i) -eq 0 ]
		then
			first_array+=( $i )	
		fi
	done
	for (( i=1; i<=$second; i++ ))
	do
		if [ $(expr $second % $i) -eq 0 ]
		then
			second_array+=( $i )	
		fi
	done
	for (( i=0; i<${#first_array[@]}; i++ ))
	do
		for (( j=0; j<${#second_array[@]}; j++ ))
		do
			if [ ${first_array[i]} -eq ${second_array[j]} ]
			then
				third_array+=( ${first_array[i]} )
			fi
		done
	done
	echo "Greatest divider is:"
	echo ${third_array[${#third_array[@]}-1]}
}
greatestDivider
