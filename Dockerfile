FROM openkbs/jdk-mvn-py3-vnc

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

ARG INSTALL_DIR=${INSTALL_DIR:-/opt}

ARG PRODUCT_VER=${PRODUCT_VER:-2018.3.4}

ARG PRODUCT_NAME=pycharm-community
ARG PRODUCT_EXE_NAME=pycharm.sh
ARG PRODUCT_URL_ROOT=https://download.jetbrains.com/python
##
ARG PRODUCT_TGZ=${PRODUCT_TGZ:-${PRODUCT_NAME}-${PRODUCT_VER}.tar.gz}
ARG PRODUCT_URL=${PRODUCT_URL:-${PRODUCT_URL_ROOT}/${PRODUCT_TGZ}}
ARG PRODUCT_HOME=${PRODUCT_HOME:-${INSTALL_DIR}/${PRODUCT_NAME}-${PRODUCT_VER}}
ARG PRODUCT_HOME_LINK=${PRODUCT_LINK:-${INSTALL_DIR}/${PRODUCT_NAME}}
ARG PRODUCT_EXE=${PRODUCT_HOME}/bin/${PRODUCT_EXE_NAME}

############################# 
#### ---- Install Target ----
############################# 
WORKDIR ${INSTALL_DIR}

RUN sudo wget ${PRODUCT_URL} && \
    sudo tar xvf ${PRODUCT_TGZ} && \
    sudo rm ${PRODUCT_TGZ}

ENV USER=${USER:-developer}
ENV DATA=${HOME}/data
ENV WORKSPACE=${HOME}/workspace

RUN sudo ln -s ${PRODUCT_EXE} /usr/bin/$(basename ${PRODUCT_EXE}) && \
    sudo chmod a+x  ${PRODUCT_EXE} /usr/bin/$(basename ${PRODUCT_EXE}) && \
    sudo chown -R ${USER}:${USER} ${PRODUCT_HOME} && \
    ls -al ${PRODUCT_HOME}

## -- PyCharm related files ---
# drwxr-xr-x 4 root root 4096 Feb  1 18:00 .PyCharmCE2018.1
# drwxr-xr-x 4 root root 4096 Feb  1 18:00 .java
# -rw-r--r-- 1 root root  148 Aug 17  2015 .profile
# drwxr-xr-x 3 root root 4096 Feb  1 18:00 PycharmProjects

## ---- user: developer ----
ENV USER=${USER:-developer}
ENV HOME=/home/${USER}

## ---- update pip3 ----
RUN mkdir -p ${DATA} ${WORKSPACE} && \
    sudo chown -R ${USER}:${USER} $HOME
    
RUN sudo -H pip3 install --upgrade pip && \
    sudo -H pip3 install geopy

##################################
#### VNC ####
##################################
VOLUME ${DATA}
VOLUME ${WORKSPACE}

USER "${USER}"

WORKDIR ${WORKSPACE}

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]

##################################
#### PyCharm ####
##################################

RUN ln -s ${PRODUCT_EXE} $HOME/pycharm.sh && ls -al $HOME/pycharm.sh
CMD "$HOME/pycharm.sh"
## -rwxr-xr-x 1 developer developer 6859 Jan 29 12:24 /usr/pycharm-community-2018.3.4/bin/pycharm.sh
## lrwxrwxrwx 1 developer developer 46 Feb  2 05:57 /home/developer/pycharm.sh -> /usr/pycharm-community-2018.3.4/bin/pycharm.sh

## ---- Debug Use ----
#CMD ["/bin/bash"]
# (or)
#COPY ./test/say_hello.sh $HOME/
#RUN sudo chmod +x $HOME/say_hello.sh
#CMD "$HOME/say_hello.sh"
