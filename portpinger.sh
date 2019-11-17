#!/bin/bash

# Script by clarsen-007 @ https://github.com/clarsen-007


if [ -z "$1" ]
  then
    echo -e " \n "
    echo -e " No argument supplied \n "
    echo -e "     -- type -h for HELP!! \n "
    echo -e " \n "
        else


if [ "$1" == "-h" ]
   then
     echo -e " \n "
     echo -e "Help Info \n "
     echo -e " Usage... \n"
     echo -e " portpinger.sh ARG1 ARG2 ARG3 ARG4"
     echo -e " ARG1 URL or IP address"
     echo -e " ARG2 port number"
     echo -e " ARG3 select tcp or udp"
     echo -e " ARG3 number of pings as count \n"
     echo -e " Example... \n"
     echo -e " portpinger.sh www.google.com 80 tcp 2"
     echo -e " \n "
   else

echo -e " Pinging $1 on PORT $2 TYPE $3 - COUNTS $4... \n"

for i in $(eval echo "{1..$4}")
   do
   start=$(date +%s%N | cut -b1-13)
         $(echo >/dev/$3/$1/$2) > /dev/null 2> /dev/null && echo "$2 is Open" > /tmp/pping1.txt || echo "$2 is Closed" > /tmp/pping1.txt
   end=$(date +%s%N | cut -b1-13)
      triptime=$((end-start))
       printf "%.3f ms\n" $(echo "$triptime / 1000" | bc -l) > /tmp/pping2.txt
       echo "Count $i" > /tmp/pping3.txt
       sleep 1
          cat /tmp/pping3.txt | tr '\n' ' ' && echo "Port $(cat /tmp/pping1.txt)" | tr '\n' ' ' && echo "Delay time $(cat /tmp/pping2.txt)"
   $i=$i+1 &>/dev/null
   done 2> /dev/null

fi ;

fi
