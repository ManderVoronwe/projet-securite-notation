#!/bin/bash

SERVER=$1
GRP=$2
total_connected=0

while read line
do
    username=$(echo $line | cut -d " " -f2)
    password=$(echo $line | cut -d " " -f3)
    sshpass -p $password  ssh -q $username@$SERVER exit
    if [[ $? -eq 0 ]]
    then
        total_connected=$(($total_connected+1))
    fi
done < <(mysql -h 10.99.99.1 -uroot -proot -B $GRP -e "SELECT * FROM sshaccount;" | sed '1d')

echo $total_connected