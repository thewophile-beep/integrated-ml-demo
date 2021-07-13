ARG IMAGE=containers.intersystems.com/intersystems/iris-ml-community:2021.1.0.215.0
ARG IMAGE=containers.intersystems.com/intersystems/iris-ml-community:2020.3.0.304.0
ARG IMAGE=arti.iscinternal.com/intersystems/iris:2021.1.0PYTHON.300.0


FROM $IMAGE
# copy files
COPY key/iris.key /usr/irissys/mgr/iris.key

USER root

# Update package and install sudo
RUN apt-get update && apt-get install -y \
	nano \
	sudo && \
	/bin/echo -e ${ISC_PACKAGE_MGRUSER}\\tALL=\(ALL\)\\tNOPASSWD: ALL >> /etc/sudoers && \
	sudo -u ${ISC_PACKAGE_MGRUSER} sudo echo enabled passwordless sudo-ing for ${ISC_PACKAGE_MGRUSER}

WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
USER ${ISC_PACKAGE_MGRUSER}
COPY . /opt/irisapp

# load demo stuff
RUN iris start IRIS \
	&& iris session IRIS < /opt/irisapp/iris.script && iris stop IRIS quietly

ARG PYTHON_PATH=/usr/irissys/bin/irispython
ARG FLASK_PATH=/opt/irisapp/src/flask
RUN ${PYTHON_PATH} -m pip install -r ${FLASK_PATH}/requirements.txt
