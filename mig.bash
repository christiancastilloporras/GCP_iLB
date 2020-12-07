#!/bin/bash

gateway=$(ip route get 10.0.0.0/8 | grep -Po '(?<=via )(\d{1,3}.){4}')
alias=$1

clish -c 'add interface eth1 alias $alias' -s
clish -c 'set static-route 130.211.0.0/22 nexthop gateway address $gateway on' -s
clish -c 'set static-route 35.191.0.0/16 nexthop gateway address $gateway on' -s

exit 0
