## Yi-OpenVINO
Building OpenVINO Docker Image

### Clone Repository:###

* git clone --branch=master --depth=1 https://bitbucket.org/yi-israel/openvino/

* cd openvino 

### Build the docker: ###

* docker build -f Dockerfile-OpenVINO-1.144 -t yi/openvino:1.144 .
* docker build -f Dockerfile-OpenVINO-2.242 -t yi/openvino:2.242 .
* docker build -f Dockerfile-OpenVINO-2.242 -t yi/openvino:3.334 .


### Running docker container: ###

* docker run -it -d  --name openvino-1.144 -v /media:/media yi/openvino:1.144
* docker run -it -d  --name openvino-2.242 -v /media:/media yi/openvino:2.242
* docker run -it -d  --name openvino-3.334 -v /media:/media yi/openvino:3.334
* yi-dockeradmin openvino-X.XXX


### Running tests manually as root inside docker container: ###

#### OpenVINO---1.144 ####

---------------------------------------------------
~~~

cd /opt/intel/openvino/deployment_tools/demo

./demo_squeezenet_download_convert_run.sh

pv /media/common/DOWNLOADS/UBUNTU/OpenVINO/DEMO/squeezenet1.1.xml > /opt/intel/openvino_2019.1.144/deployment_tools/demo/squeezenet1.1.xml

pv /media/common/DOWNLOADS/UBUNTU/OpenVINO/DEMO/squeezenet1.1.bin > /opt/intel/openvino_2019.1.144/deployment_tools/demo/squeezenet1.1.bin

cd /opt/intel/openvino_2019.1.144/deployment_tools/inference_engine/samples/python_samples

python classification_sample/classification_sample.py -m /opt/intel/openvino_2019.1.144/deployment_tools/demo/squeezenet1.1.xml -i /opt/intel/openvino_2019.1.144/deployment_tools/demo/car.png

~~~
---------------------------------------------------

#### OpenVINO---2.242 ####

---------------------------------------------------
~~~
cd /opt/intel/openvino/deployment_tools/demo

./demo_squeezenet_download_convert_run.sh

pv /media/common/DOWNLOADS/UBUNTU/OpenVINO/DEMO/squeezenet1.1.xml > /opt/intel/openvino_2019.2.242/deployment_tools/demo/squeezenet1.1.xml

pv /media/common/DOWNLOADS/UBUNTU/OpenVINO/DEMO/squeezenet1.1.bin > /opt/intel/openvino_2019.2.242/deployment_tools/demo/squeezenet1.1.bin

cd /opt/intel/openvino_2019.2.242/deployment_tools/inference_engine/samples/python_samples

python classification_sample/classification_sample.py -m /opt/intel/openvino_2019.2.242/deployment_tools/demo/squeezenet1.1.xml -i /opt/intel/openvino_2019.2.242/deployment_tools/demo/car.png

~~~
---------------------------------------------------

#### OpenVINO---3.334 ####

---------------------------------------------------
~~~
cd /opt/intel/openvino/deployment_tools/demo

./demo_squeezenet_download_convert_run.sh

pv /media/common/DOWNLOADS/UBUNTU/OpenVINO/DEMO/squeezenet1.1.xml > /opt/intel/openvino_2019.3.334/deployment_tools/demo/squeezenet1.1.xml

pv /media/common/DOWNLOADS/UBUNTU/OpenVINO/DEMO/squeezenet1.1.bin > /opt/intel/openvino_2019.3.334/deployment_tools/demo/squeezenet1.1.bin

cd /opt/intel/openvino_2019.3.334/deployment_tools/inference_engine/samples/python_samples

python classification_sample/classification_sample.py -m /opt/intel/openvino_2019.3.334/deployment_tools/demo/squeezenet1.1.xml -i /opt/intel/openvino_2019.3.334/deployment_tools/demo/car.png

~~~
---------------------------------------------------

### Running test as non-root user inside docker container: ###

---------------------------------------------------
~~~

su openvino

cd /tmp

cp -R /media/common/USERS/Sagi/OpenVINO .

cd OpenVINO/

python ssh_v2_VINO.py

~~~
---------------------------------------------------

### Reference ###

https://software.intel.com/en-us/articles/use-an-inference-engine-api-in-python-to-deploy-the-openvino-toolkit
