#!/bin/bash
make -j16
OMP_NUM_THREADS=32 numactl -N 0 /data3/panyj/grappolo/driverForGraphClustering -f 9 /data3/panyj//dataset/SNAP/com-lj.ungraph.txt.bin -y 0 -v -c 1
