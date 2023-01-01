#!/bin/bash

SERVER=$1
GRP=$2
CERTIFICATE="/app/cert/sshdocker"
total_connected=0

while read line
do
    username=$(echo $line | cut -d " " -f2)
    password=$(echo $line | cut -d " " -f3)
    test=$(ssh -i $CERTIFICATE root@$SERVER "mysql -h127.0.0.1 -u$username -p$password -e \"USE maki2;\"")
    if [[ $test -eq 0 ]]
    then
        total_connected=$(($total_connected+1))
    fi
done < <(mysql -h 10.99.99.1 -uroot -proot -B $GRP -e "SELECT * FROM mysqlaccount;" | sed '1d')

echo $total_connected