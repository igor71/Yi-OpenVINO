### Clone Repository:

*  git clone --branch=3.334 --depth=1 https://github.com/igor71/Yi-OpenVINO 

*  cd Yi-OpenVINO

### Build the docker container from Dockerfile: ###

* docker build -f Dockerfile-OpenVINO-3.334 -t yi/openvino:3.334 .

### Running docker container: ###

* docker run -it -d  --name openvino-3.334 -v /media:/media yi/openvino:3.334
* yi-dockeradmin openvino-3.334

### Build the docker container from Dockerfile using Docker-Compose command : ###

~~~
git clone --branch=3.334 --depth=1 https://github.com/igor71/Yi-OpenVINO

cd Yi-OpenVINO

docker-compose -f docker-compose.yml up -d --build

~~~


### Build the docker container on AWS from Dockerfile-AWS using Docker-Compose command : ###

~~~
git clone --branch=3.334 --depth=1 https://github.com/igor71/Yi-OpenVINO

cd Yi-OpenVINO

sed -i '/        dockerfile: Dockerfile/c\        dockerfile: Dockerfile-AWS' $PWD/docker-compose.yml

docker-compose -f docker-compose.yml up -d --build

~~~

### Build the docker container using bash script : ###

~~~
git clone --branch=3.334 --depth=1 https://github.com/igor71/Yi-OpenVINO

cd Yi-OpenVINO

bash build-script.sh

~~~


### Notes:
* Dockerfile-OpenVINO-3.334 will use build from the sources python 3.6.8
* Dockerfile-PyENV will use installation of python 3.6.8 into PYENV user folder
* Dockerfile will use build in python 3.6.x version as default

Need to adjust docker-compose.yml file for usage of different Dockerfiles


### Running auto tests as root inside docker container: ###

---------------------------------------------------
~~~

yi-dockeradmin $USER-openvino-3.334

cd /tmp

bash openvino_install_test.sh

~~~
---------------------------------------------------


### Running tests manually as root inside docker container: ###

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
