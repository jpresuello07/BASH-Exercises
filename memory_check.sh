#!/bin/bash
if [[ $# -eq 0 ]] ; 
then
    echo "Please input the following Parameters (in any order):"
    echo "Critical Threshold (Percentage) = -c <desired critical memory percentage>"
    echo "Warning Thre shold (Percentage) = -w <desired warning memory percentage>"
    echo "Email Address (where the report will be sent) = -e <email address>"
    echo "Example: -c 90 -w 60 -e juan123@gmail.com"
	
	exit
fi

while getopts ":c:w:e:" flag; do
	case "${flag}" in
        c)	critical=${OPTARG}
			;;
        w)	warning=${OPTARG}
            ;;
        e) 	email_add=${OPTARG}
			;;
        *)	echo "Unknown parameter/s entered. Please refer below:"
			echo "Critical Threshold (Percentage) = -c <desired critical memory percentage>)"
			echo "Warning Threshold (Percentage) = -w <desired warning memory percentage>"
			echo "Email Address (where the report will be sent) = -e <email address>"
			echo "Example: -c 90 -w 60 -e juan123@gmail.com"
			;;
    esac
done

TOTAL_MEMORY=$(free | grep Mem: | awk '{print $2}')
USED_MEMORY=$(free | grep Mem: | awk '{print $3}')
#echo "Used Memory: $TOTAL_MEMORY"

USAGE_PERCENTAGE=$(("100* $USED_MEMORY/$TOTAL_MEMORY"))
#echo $USAGE_PERCENTAGE
    

if [[ $USAGE_PERCENTAGE -ge $critical ]]
then
    #echo "Memory Usage is very High"
    exit 2
    
elif [[ $USAGE_PERCENTAGE -ge $warning ]] && [[ $USAGE_PERCENTAGE -lt $critical ]]
then
    #echo "Memory Usage is higher than normal but not critical"
    exit 1
    
else
    #echo "Memory Usage is normal"
    exit 0
fi

exit
