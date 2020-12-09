#!/bin/bash

gateway=<change for next hop>
alias=<change for ilb ip>

clish -c 'add interface eth1 alias $alias' -s
clish -c 'set static-route 130.211.0.0/22 nexthop gateway address $gateway on' -s
clish -c 'set static-route 35.191.0.0/16 nexthop gateway address $gateway on' -s

exit 0
