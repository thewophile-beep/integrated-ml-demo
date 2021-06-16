ARG IMAGE=containers.intersystems.com/intersystems/iris-ml-community:2021.1.0.215.0
FROM $IMAGE
# copy files
COPY . /tmp/iris

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

# load demo stuff
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris/iris.script && iris stop IRIS quietly
