#!/bin/bash
primeNumbers() {
	red='\033[0;31m'
	white='\033[0m'
	echo "Enter range:"
	read range
	if ! [[ $range =~ ^[0-9]+$ ]]
	then
		echo -e "${red}Enter only number${white}"
		primeNumbers
		return 0
	fi
	prime_numbers=()
	echo "Wait..."
	for (( i=1; i<=$range; i++ ))
	do
		state=0
		for (( j=2; j<i; j++ ))
		do
			if [ $(expr $i % $j) -eq 0 ]
			then
				state=1
			fi
		done
		if [ $state -eq 0 ]
		then
			prime_numbers+=( $i )
		fi
	done
	echo "Prime numbers are:"
	echo ${prime_numbers[@]}
}
primeNumbers
