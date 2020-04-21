#!/bin/bash

# Script by clarsen-007 @ https://github.com/clarsen-007
# Purpose of script: "Pings", "Tests" for open ports...

VERSION=00.02.00.01

while getopts s:p:t:c:d:hv option
   do
      case "${option}"
         in
           s) SV=${OPTARG};;
           p) PORT=${OPTARG};;
           t) TYPE=${OPTARG};;
           c) COUNT=${OPTARG};;
           d) TOUT=${OPTARG};;
           h) ;;
           v) ;;
      esac
done

if [ -z "$1" ]
  then
    echo -e " \n "
    echo -e " No argument supplied \n "
    echo -e "     -- type portpinger.sh -h for HELP!! \n "
    exit
fi

if [ "$1" == "-h" ]
   then
     echo -e " \n "
     echo -e "Usage: portpinger.sh [ -s URL or IP address ] [ -p port ] "
     echo -e "                     [ -t protocol ( default TCP ) ] UDP is stateless and unreliable for ping requests "
     echo -e "                     [ -c count, number of pings ( default is 5 ) ] "
     echo -e "                     [ -d set timeout for ping TTL in seconds ( default is 5 seconds ) ] "
     echo -e "                     [ -h display help text and exit ] "
     echo -e "                     [ -v display version text and exit ] \n"
     echo -e "           Example... \n"
     echo -e "               portpinger.sh -s www.google.com -p 80 -t tcp -c 2 \n"
     exit
fi

if [ "$1" == "-v" ]
   then
     echo -e " \n "
     echo -e "Version: $VERSION \n"
     exit
fi

echo -e " \n "
echo -e " Pinging $SV on PORT $PORT \n"
     
for i in $(eval echo "{1..${COUNT:-5}}")
   do
   start=$( date +%s%N | cut -b1-13 )
         ( cmdpid=$BASHPID; ( sleep ${TOUT:-5} ; kill "$cmdpid" ) & exec $( echo >/dev/${TYPE:-tcp}/$SV/$PORT ) > \
            /dev/null 2> /dev/null && echo "$PORT is Open" > /tmp/pping1.txt || echo "$PORT is Closed" > \
            /tmp/pping1.txt ) || echo "$PORT is Closed" > /tmp/pping1.txt
   end=$( date +%s%N | cut -b1-13 )
      triptime=$(( end-start ))
       printf "%.3f ms\n" $( echo "$triptime / 1000" | bc -l ) > /tmp/pping2.txt
       echo "Count $i" > /tmp/pping3.txt
       sleep 1
          cat /tmp/pping3.txt | tr '\n' ' ' && echo "Port $( cat /tmp/pping1.txt )" | tr '\n' ' ' && \
             echo "Delay time $( cat /tmp/pping2.txt )"
   $i=$i+1 &>/dev/null
   done 2> /dev/null

# Cleanup if done - no cleanup on break

rm /tmp/pping*.txt

exit
