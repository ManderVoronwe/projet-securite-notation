#!/bin/bash

# get launch parameters
$server = $args[0]

# get all processus from a distant server
$processus = Get-WmiObject -ComputerName $server -Class Win32_Process

#save processus in a file
$processus | Out-File -FilePath ".\processus.txt"
