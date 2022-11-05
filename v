#!/bin/bash

file_input="task4.txt"
file_output="task5.txt"

ppid_prev="0"
ART_sum="0"
cnt="0"
avg="0"

echo -e "$(<"$file_input")\n" | sed "s/[^0-9.]\+/ /g" | sed "s/^ //g" |
while read line
do
	pi_cur=$(awk '{print $1}' <<< $line)
	ppid_cur=$(awk '{print $2}' <<< $line)
	ART=$(awk '{print $3}' <<< $line)

	if [[ $ppid_cur == $ppid_prev ]]
	then
		ART_sum=$(echo "$ART_sum $ART" | awk '{printf "%f", $1+$2}')
		cnt=$(($cnt+1))
	else
		avg=$(echo "$ART_sum $cnt" | awk '{printf "%f", $1/$2}')
		echo "Average_Running_Children_of_ParentID="$ppid_prev" is "$avg
		ART_sum=$ART
		cnt=1
		ppid_prev=$ppid_cur
	fi

	if [[ ! -z $pid_cur ]]
	then
		echo "PID="$pid_cur" : Parent_PID="$ppid_prev" : ART="$ART
	fi


done > "$file_output"
