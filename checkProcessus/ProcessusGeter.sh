#!/bin/bash

SERVER=$1
CERTIFICATE="/app/cert/sshdocker"
PROCESSUS=(lighttpd bck php8 dock crypt)
number=0
for i in $processus
do
    number=$(($number+$(ssh -i $CERTIFICATE root@$SERVER "ps -aux | grep $i | wc -l") ))
done

echo $((-1 * $number))

