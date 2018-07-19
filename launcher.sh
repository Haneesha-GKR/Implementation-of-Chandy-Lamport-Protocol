#!/bin/bash

# Change this to your netid
netid=hxg170830

#
# Root directory of your project
PROJDIR=$HOME/finalpro

#
# This assumes your config file is named "config.txt"
# and is located in your project directory
#
CONFIG=Document.txt

#
# Directory your java classes are in
#
BINDIR=$PROJDIR/src
#/bin

#DUMPDIR
DUMPDIR=$PROJDIR/dump

#
# Your main project class
#
PROG=DriverMain

i=0

cat $CONFIG | sed -e "s/#.*//" | sed -e "/^\s*$/d" |
(
	read n
	n=$( echo $n| awk '{ print $1}' )
	echo $n

	while [ "$i" -ne "$n" ]
	do
		read line 

		i=$( echo $line | awk '{ print $1 }' )
		host=$( echo $line | awk '{ print $2 }' )
		port=$( echo $line | awk '{ print $3 }' )
		# echo $i $host $port

		hosts_list[$i]=$host
		i=$(( i + 1 ))
	done

	i=0

	while [ "$i" -ne "$n" ]
	do
		host=${hosts_list[$i]}
		echo host=$host, i=$i
		# echo "cd $BINDIR; ./$PROG $i > dump_$i.txt &"
        ssh -o StrictHostkeyChecking=no $netid@$host "cd $BINDIR; java $PROG $i $CONFIG > $DUMPDIR/dump_$i.txt &"
        # ./$PROG $i > config_$i.txt&


        i=$(( i + 1 ))
    done

)