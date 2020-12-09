#!/bin/bash

clish -c 'add interface eth1 alias <change for ilb ip with mask>' -s
clish -c 'set static-route 130.211.0.0/22 nexthop gateway address <change for the gateway IP on eth1 subnet> on' -s
clish -c 'set static-route 35.191.0.0/16 nexthop gateway address <change for the gateway IP on eth1 subnet> on' -s

exit 0
