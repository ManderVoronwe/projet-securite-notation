#!/bin/bash

SERVER=$1
CERTIFICATE="/app/cert/sshdocker"

test=$(ssh -i $CERTIFICATE root@$SERVER "netstat | grep 10.99.99.1:90 | wc -l")
if [[ $test > "0" ]]
then
    echo -2
else
    echo 0
fi