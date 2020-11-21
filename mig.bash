#!/bin/bash

cidr=$1
alias=$2

function get_router() {
    local interface="$1"
    local subnet_router_meta_path="computeMetadata/v1/instance/network-interfaces/$interface/gateway"
    local router="$(get-cloud-data.sh ${subnet_router_meta_path})"
    echo "${router}"
}

function set_internal_static_lb_routes() {
    local lb_cidrs='130.211.0.0/22 35.191.0.0/16'
    #Define interface for internal networks and configure
    local interface="1"
    local router=$(get_router $interface)
    clish -c 'lock database override'
    #Configure static LB routes, through the  internal interface
    for cidr in ${lb_cidrs}; do
        echo "setting route to $cidr via gateway $router"
        echo "running  clish -c 'set static-route $cidr nexthop gateway address $router on' -s"
        clish -c "set static-route $cidr nexthop gateway address $router on" -s
    done
}

if [[ $cidr==no ]]
then 
    clish -c "set static-route 10.0.0.0/8 off" -s
    clish -c "set static-route 172.16.0.0/12 off" -s
    clish -c "set static-route 192.168.0.0/16 off" -s
fi

clish -c "add interface eth1 alias $alias" -s
set_internal_static_lb_routes

exit 0
