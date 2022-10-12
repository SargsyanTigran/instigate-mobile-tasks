#!/bin/bash
greatestNumber() {
        red='\033[0;31m'
        white='\033[0m'
	echo "Enter array of numbers:"
	read -a arr
	for num in ${arr[@]}
	do
		if ! [[ $num =~ ^[0-9]+$ ]]
		then
			echo -e "${red}Input only numbers${white}"
			greatestNumber
			return 0
		fi
	done
	max=${arr[0]}
	for num in ${arr[@]}
	do
		if [ $num -gt $max ]
		then
			max=$num
		fi
	done
	echo "The greatest number is:"
	echo $max
}
greatestNumber
