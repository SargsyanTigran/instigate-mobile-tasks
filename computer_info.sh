#!/bin/bash
green='\033[0;32m'
red='\033[0;31m'
white='\033[0m'
linuxInfo(){
	echo -e "${green}Hardware information:${white}"
	sudo lshw -short

	echo -e "${green}Operating system and system hardware information:${white}"
	uname -a

	echo -e "${green}BIOS information:${white}"
	sudo dmidecode -t bios

	cpuInfo
	ramInfo
	disksInfo
}
macOSInfo(){
	echo -e "${green}Operating system and system hardware information:${white}"
	uname -a
	
	echo -e "${green}CPU architecture information:${white}"
	sysctl -a | grep machdep.cpu

	echo -e "${green}Hardware information:${white}"
	system_profiler SPHardwareDataType 
	
	echo -e "${green}RAM usage:${white}"
	top -l 1 -s 0 | grep PhysMem
	
	echo -e "${green}Disks information:${white}"
	diskutil list
}
cpuInfo() {
        echo -e "${green}CPU information:${white}"

        cpu_vendor_name=$( cat /proc/cpuinfo | grep -m1 "vendor_id" )
        echo "CPU's $cpu_vendor_name"

        cpu_model_name=$( cat /proc/cpuinfo | grep -m1 "model name" )
        echo "CPU's $cpu_model_name"

        cpu_cache=$( cat /proc/cpuinfo | grep -m1 "cache size" )
        echo "$cpu_cache"

        cpu_frequency=$( cat /proc/cpuinfo | grep -m1 "cpu MHz" )
        echo "$cpu_frequency MHz"

        cpu_cores_number=$( cat /proc/cpuinfo | grep -m1 "cpu cores" )
        echo -e "$cpu_cores_number"
}
ramInfo() {
        echo -e "${green}RAM information${white}" 

        total_memory_size=$( free --mega | grep "Mem" | awk '{print $2}' )
        echo "Total memory of RAM: $total_memory_size MB"

        used_memory_size=$( free --mega | grep "Mem" | awk '{print $3}' )
        echo "Used memory of RAM: $used_memory_size MB"

        free_memory_size=$( free --mega | grep "Mem" | awk '{print $4}' )
        echo "Free memory of RAM: $free_memory_size MB"

        available_memory_size=$( free --mega | grep "Mem" | awk '{print $7}' )
        echo "Available memory of RAM: $available_memory_size MB"

        memory_type=$( sudo dmidecode -t 17 | grep -m1 "Type:" | awk '{$1=""; print $0}' )
        echo "Memory type: $memory_type"

        memory_speed=$( sudo dmidecode -t memory | grep -m1 "Speed:" | awk '{$1=""; print $0}' )
        echo -e "Memory speed: $memory_speed"
}
disksInfo() {
        echo -e "${green}Disks information:${white}"

        disk_count=$( sudo fdisk -l | grep -c '/dev/sda')
        echo -e "Device\t\tSize\t\tType"

        disk=$( sudo fdisk -l | grep -A$(($disk_count - 1)) "/dev/sda1" | awk -e '{print $1,"\t"$5, "\t\t"$6}')
        echo "$disk"
}

if [[ $(uname) == "Linux" ]]
then
	linuxInfo
elif [[ $(uname) == "Darwin" ]]
then
	macOSInfo
else
	echo -e "${red}The code not supported in your Operating System${white}"
fi
