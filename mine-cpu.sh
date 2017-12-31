#!/bin/bash

HOSTNAME=$(hostname)-CPU
ALL_CPU_THREADS=$(cat /proc/cpuinfo | grep -i processor | wc -l)
MINER_CPU_THREADS=$((ALL_CPU_THREADS-2))

cd eth-proxy
screen -dm -S eth-proxy bash -c "python eth-proxy.py"
cd -

screen -dm -S cpu-miner bash -c "ethminer -C -F http://127.0.0.1:8080/${HOSTNAME} --farm-recheck 200 -t $MINER_CPU_THREADS"
