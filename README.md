# PyCharm IDE in a VNC/noVNC-based Docker container

[![](https://images.microbadger.com/badges/image/openkbs/pycharm-docker.svg)](https://microbadger.com/images/openkbs/pycharm-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/pycharm-docker.svg)](https://microbadger.com/images/openkbs/pycharm-docker "Get your own version badge on microbadger.com")


# License Agreement
By using this image, you agree the [Oracle Java JDK License](http://www.oracle.com/technetwork/java/javase/terms/license/index.html).
This image contains [Oracle JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html). You must accept the [Oracle Binary Code License Agreement for Java SE](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) to use this image.

# Components
* PyCharm version PyCharmCE2018.3
* java version "1.8.0_201"
  Java(TM) SE Runtime Environment (build 1.8.0_201-b09)
  Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode)
* Apache Maven 3.6.0
* Python 3.5.2
* node v11.7.0 + npm 6.5.0 (from NodeSource official Node Distribution)
* Gradle 5.1
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 
* VNC/noVNC for remote Desktop over Container Platform (Openshift, Kubernetes, etc.) 

# Run (recommended for easy-start)
* Once the above build is done, you can run IntelliJ now using the command below.
```
./run.sh
```

# Deployment over Openshift or Kubernetes
You need to manually provide the environment variables for deployment (since run.sh automatically aggregate all the needed variables for running the PyCharm docker container to ensure the persistent information stayed with the host directories even you delete the container instances.
Here is what you need to setup in Openshift "deployment" configuration GUI or YAML template (from docker-compose.yaml file below):
```
    volumes:
      - ./PycharmProjects:/home/developer/PycharmProjects
      - ./.PyCharmCE2018.3:/home/developer/.PyCharmCE2018.3
      - ./.profile:/home/developer/.profile
      - ./.java:/home/developer/.java
      - ./data:/home/developer/data
      - ./workspace:/home/developer/workspace
```
# Build
You can build your own image locally.

```
./build.sh
```

# (Optional) Making plugins persist between sessions
If you run "./run.sh" instead of "docker-compose up", **you don't have to do anything as below**.

PyCharm configurations are kept on `$HOME/PyCharmCE2018.[N]` inside the container, so if you
want to keep them around after you close it, you'll need to share it with your
host.

For example: (Version might be different - use run.sh instead)

```
docker run -ti --rm \
           -e DISPLAY=$DISPLAY \
           -v $HOME/PyCharmCE2018.[N]:/home/developer/PyCharmCE2018.[N] \
           -v `pwd`:/home/developer/workspace \
           openkbs/PyCharm-docker
```

# See also X11 and VNC/noVNC docker-based IDE collections
* [openkbs/docker-atom-editor](https://hub.docker.com/r/openkbs/docker-atom-editor/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/eclipse-phonto-vnc-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/eclipse-photon-vnc-docker)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-photon-vnc-docker](https://hub.docker.com/r/openkbs/eclipse-photon-vnc-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/intellj-vnc-docker](https://hub.docker.com/r/openkbs/intellij-vnc-docker/)
* [openkbs/knime-vnc-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/knime-vnc-docker)
* [openkbs/knime-vnc-docker](https://hub.docker.com/r/openkbs/knime-vnc-docker/)
* [openkbs/mysql-workbench-vnc-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/mysql-workbench-vnc-docker)
* [openkbs/netbeans10-docker](https://hub.docker.com/r/openkbs/netbeans10-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/pycharm-vnc-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/pycharm-vnc-docker)
* [openkbs/rapidminer-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/rapidminer-docker)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)
* [openkbs/webstorm-vnc-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/webstorm-vnc-docker)
* [openkbs/webstorm-vnc-docker](https://hub.docker.com/r/openkbs/webstorm-vnc-docker/)
* [openkbs/rest-dev-vnc-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/rest-dev-vnc-docker)

# See Also - Docker-based SQL GUI
* [Sqlectron SQL GUI at openkbs/sqlectron-docker](https://hub.docker.com/r/openkbs/sqlectron-docker/)
* [Mysql-Workbench at openkbs/mysql-workbench](https://hub.docker.com/r/openkbs/mysql-workbench/)
* [PgAdmin4 for PostgreSQL at openkbs/pgadmin-docker](https://hub.docker.com/r/openkbs/pgadmin-docker/)

# Reference
* https://download.jetbrains.com/idea
* https://www.jetbrains.com/idea/
* https://www.jetbrains.com/pycharm/

# Releases information
```
root@6dc0b2859b9d:~# /usr/printVersions.sh 
+ echo JAVA_HOME=/usr/java
JAVA_HOME=/usr/java
+ java -version
java version "1.8.0_201"
Java(TM) SE Runtime Environment (build 1.8.0_201-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode)
+ mvn --version
Apache Maven 3.6.0 (97c98ec64a1fdfee7767ce5ffb20918da4f719f3; 2018-10-24T18:41:47Z)
Maven home: /usr/apache-maven-3.6.0
Java version: 1.8.0_201, vendor: Oracle Corporation, runtime: /usr/jdk1.8.0_201/jre
Default locale: en_US, platform encoding: ANSI_X3.4-1968
OS name: "linux", version: "4.15.0-43-generic", arch: "amd64", family: "unix"
+ python -V
Python 2.7.12
+ python3 -V
Python 3.5.2
+ pip --version
pip 18.1 from /usr/local/lib/python3.5/dist-packages/pip (python 3.5)
+ pip3 --version
pip 18.1 from /usr/local/lib/python3.5/dist-packages/pip (python 3.5)
+ gradle --version

------------------------------------------------------------
Gradle 5.1.1
------------------------------------------------------------

Build time:   2019-01-10 23:05:02 UTC
Revision:     3c9abb645fb83932c44e8610642393ad62116807

Kotlin DSL:   1.1.1
Kotlin:       1.3.11
Groovy:       2.5.4
Ant:          Apache Ant(TM) version 1.9.13 compiled on July 10 2018
JVM:          1.8.0_201 (Oracle Corporation 25.201-b09)
OS:           Linux 4.15.0-43-generic amd64

+ npm -v
6.5.0
+ node -v
v11.7.0
+ cat /etc/lsb-release /etc/os-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.3 LTS"
NAME="Ubuntu"
VERSION="16.04.3 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.3 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```
