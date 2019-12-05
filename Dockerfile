FROM ubuntu:18.04

#################################################
#  Update repositories -- we will need them all #
#  the time, also when container is run         #
#################################################

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update


################################################
#     Basic desktop environment                #
################################################

# Locale, language
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK, fixing...
# http://bugs.python.org/issue19846
ENV LANG C.UTF-8


#################################################
#     Very basic installations                  #
#################################################

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y --no-install-recommends \
    software-properties-common \
    build-essential \
    openssh-client \
    python3-dev \
    apt-utils \
    curl \
    wget \
    tree \
    vim \
    zip \
    unzip \
    rsync \
    screen \
    nano \
    htop \
    iputils-ping \
    pv \
    sudo \
    cpio \
    git


###########################################################
#            Setting Python3 Alias For All Users          #
###########################################################

RUN sed -i '$a\\' /etc/bash.bashrc && \
    sed -i '$a\###### Use Python 3.6 by default ###########\' /etc/bash.bashrc && \
    sed -i '$a\alias python='python3.6'\' /etc/bash.bashrc && \
    sed -i '$a\############################################\' /etc/bash.bashrc
ARG PY=python3.6
RUN ${PY} --version && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10 && \
    curl -fSsL -O ftp://jenkins-cloud/pub/Develop/get-pip.py && \
    ${PY} get-pip.py && \
    rm get-pip.py


#################################
#     Python Installations      #
#################################

RUN ${PY} -m pip --no-cache-dir install \
    ipykernel \
    image \
	networkx==2.3.0 \
    matplotlib \
    opencv-python \
    numpy  && \
    ${PY} -m ipykernel.kernelspec && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


#################################################
#                Installing OpenVINO             #
##################################################

ARG VER=l_openvino_toolkit_p_2019.3.334.tgz
COPY Config/openvino.conf_2019.3.334 /etc/ld.so.conf.d/openvino.conf
COPY Config/openvino_install_test.sh /tmp/openvino_install_test.sh
RUN cd /tmp && \
    curl -OSL ftp://jenkins-cloud/pub/Tflow-VNC-Soft/OpenVINO/${VER} -o ${VER} && \
    pv -f ${VER} | tar xpzf - -C $PWD && \
    cd l_openvino_toolkit_p_2019.3.334 && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh -s silent.cfg --ignore-signature && \
    cd /opt/intel/openvino/install_dependencies && \
    ./install_openvino_dependencies.sh && \
    pv -f /opt/intel/openvino/bin/setupvars.sh > /tmp/setupvars.sh && \
    chmod o+x /tmp/setupvars.sh && \
    ldconfig && \
    cd /tmp && \
    rm -rf l_openvino_toolkit_p_2019.3.334* && \
    cd /opt/intel/openvino_2019.3.334/deployment_tools/inference_engine/samples/python_samples/classification_sample && \
    sed -i "24 a sys.path.append('/opt/intel/openvino_2019.3.334/python/python3.6/')" classification_sample.py && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


#######################################
# Set User OPENVINO User To The image #
#######################################

RUN useradd -m -d /home/openvino -s /bin/bash openvino && \
    echo "openvino:openvino" | chpasswd && \

# Add openvino user to sudoers
    sed -i '23 a openvino  ALL=(ALL)  NOPASSWD: ALL' /etc/sudoers


#########################################
# Add Welcome Message With Instructions #
#########################################

RUN  printf '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' \
        >> /etc/bash.bashrc \
        ; printf "\
||||||||||||||||||||||||||||||||||||\n\
|                                  |\n\
| Build Server Running Ubuntu 18   |\n\
| Using As Linux Build Environment |\n\
| Based On OpenVINO v.2019.3.334   |\n\
|                                  |\n\
||||||||||||||||||||||||||||||||||||\n\
\n "\
        > /etc/motd