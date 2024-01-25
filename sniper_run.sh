SNIPER_ROOT=/data3/panyj/snipersim
RUN_SNIPER=${SNIPER_ROOT}/run-sniper
GRAPPOLO_ROOT=/data3/panyj/grappolo
GRAPH=com-lj
DATASET=../dataset/SNAP/${GRAPH}.ungraph.txt.bin
COMMAND="./driverForGraphClustering -f 9 ${DATASET} -c 1 -v"
# OMP_NUM_THREADS=32 ${COMMAND}

core_number=32
cd ${SNIPER_ROOT}
sed -i '13d' ${SNIPER_ROOT}/config/gainestown.cfg
sed -i '13i cache_size = '''$(( 2048*core_number))'''' ${SNIPER_ROOT}/config/gainestown.cfg
sed -i '21d' ${SNIPER_ROOT}/config/gainestown.cfg
sed -i '21i shared_cores = '''${core_number}'''' ${SNIPER_ROOT}/config/gainestown.cfg
sed -i '32d' ${SNIPER_ROOT}/config/gainestown.cfg
sed -i '32i controllers_interleaving = '''${core_number}'''' ${SNIPER_ROOT}/config/gainestown.cfg
make

cd ${GRAPPOLO_ROOT}
make

OMP_NUM_THREADS=32 OMP_WAIT_POLICY=passive $RUN_SNIPER -d ./profile/${GRAPH} -c gainestown -n 32 --no-cache-warming --roi -- ${COMMAND}