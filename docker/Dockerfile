FROM nvcr.io/nvidia/isaac-sim:2022.1.1

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install basics
RUN apt-get update -y
#     && apt-get install build-essential \
#     && apt-get install -y apt-utils git curl ca-certificates bzip2 tree htop wget \
#     && apt-get install -y libglib2.0-0 libsm6 libxext6 libxrender-dev bmon iotop g++ 
RUN apt-get install -y python3.7 python3.7-dev python3.7-distutils

RUN apt-get update && apt-get install -y software-properties-common
RUN apt-get update -q && \
    apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion

# Install cmake v3.13.2
RUN apt-get purge -y cmake && \
    mkdir /root/temp && \
    cd /root/temp && \
    wget https://github.com/Kitware/CMake/releases/download/v3.13.2/cmake-3.13.2.tar.gz && \
    tar -xzvf cmake-3.13.2.tar.gz && \
    cd cmake-3.13.2 && \
    bash ./bootstrap && \
    make && \
    make install && \
    cmake --version && \
    rm -rf /root/temp

RUN apt-get install -y tmux tmuxp 
RUN apt-get install -y x11-xserver-utils
RUN apt-get install -y libnvidia-gl-510 x11-apps 

# Install python
RUN ln -sv /usr/bin/python3.7 /usr/bin/python
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py \
    rm -f get-pip.py

RUN echo 'alias PYTHON_PATH=/isaac-sim/python.sh' >> ~/.bashrc

# RUN locale-gen en_US.UTF-8
# RUN useradd -m -d /home/ubuntu ubuntu -p `perl -e 'print crypt("ubuntu", "salt"),"\n"'` && \
#     echo "ubuntu ALL=(ALL) ALL" >> /etc/sudoers
# USER ubuntu
# # WORKDIR /home/ubuntu
# ENV HOME=/home/ubuntu \
#     CATKIN_SHELL=bash
# ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

WORKDIR /root
