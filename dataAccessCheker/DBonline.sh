#!/bin/bash

SERVER=$1

{echo "quit";sleep 1;} | telnet $SERVER 3306 &> /dev/null | grep "Connected" | wc -l
if [[ $? -gt 0 ]]
then
  echo -200
else
    echo 0
fi