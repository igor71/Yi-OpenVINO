#! /bin/bash

# Test #1

cd /opt/intel/openvino/deployment_tools/demo

./demo_squeezenet_download_convert_run.sh

RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
CYAN='\033[0;36m'

if [ $? -ne 0 ]; then
   printf "${RED}Test #1 failed!!!${NC} Please check OpenVino installation\n"
   exit 1
fi

printf "${GREEN}Test #1 passed successfully!!!${NC}\n"

printf "${CYAN}Hi, I'm sleeping for 10 seconds before next test...${NC}\n"

sleep 10

# Test #2

pv /media/common/DOWNLOADS/UBUNTU/OpenVINO/DEMO/squeezenet1.1.xml > /opt/intel/openvino_2019.2.242/deployment_tools/demo/squeezenet1.1.xml

pv /media/common/DOWNLOADS/UBUNTU/OpenVINO/DEMO/squeezenet1.1.bin > /opt/intel/openvino_2019.2.242/deployment_tools/demo/squeezenet1.1.bin

cd /opt/intel/openvino_2019.2.242/deployment_tools/inference_engine/samples/python_samples

python classification_sample/classification_sample.py -m /opt/intel/openvino_2019.2.242/deployment_tools/demo/squeezenet1.1.xml -i /opt/intel/openvino_2019.2.242/deployment_tools/demo/car.png

if [ $? -ne 0 ]; then
   printf "${RED}Test #2 failed!!!${NC} Please check classification_sample.py script file\n"
   exit 1
fi

printf "${GREEN}Test #2 passed successfully!!!${NC}\n"

printf "${CYAN}Hi, I'm sleeping for 10 seconds before next test...${NC}\n"

# Test #3

sleep 10

cd /tmp

cp -R /media/common/USERS/Sagi/OpenVINO .

cd OpenVINO/

sed -i '8d' ssh_v2_VINO.py

sed -i "7 a sys.path.append('/opt/intel/openvino_2019.2.242/python/python3.6/')" ssh_v2_VINO.py

python ssh_v2_VINO.py

cd ..

rm -rf OpenVINO

if [ $? -ne 0 ]; then
   printf "${RED}Test #2 failed!!!${NC} Please check ssh_v2_VINO.py script file\n"
   exit 1
fi

printf "${CYAN}Test #3 passed successfully!!! All Done!!!${NC}\n"



