#!/bin/bash

SERVER=$1

test=$(echo "quit" | telnet $SERVER 3306 | grep "Connected" | wc -l)
if [[ $test -gt 0 ]]
then
  echo -200
else
  echo 0
fi