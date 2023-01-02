#!/bin/bash

URL=$1
REQUEST=$(curl -sI $URL | grep -m1 HTTP | cut -d " " -f2)

if [[ $REQUEST -eq 200 ]]
then 
  number_celene2=$(curl -s $URL/index.php | grep celene2 | wc -l)
  if [[ $number_celene2 -gt 0 ]]
  then 
    echo 10
  else
    echo 20
  fi
else
  echo 0
fi