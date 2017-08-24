#!/bin/bash

>up.txt
>down.txt

for ip in $(cat ip_addrs.txt);
do ping $ip -c 1;
    if [ $? -eq 0 ]; then
    echo $ip >> up.txt
    else
    echo $ip >> down.txt;
    fi
done
