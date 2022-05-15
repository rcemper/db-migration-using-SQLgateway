ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE

USER root   
        
WORKDIR /opt/irisbuild
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild
USER ${ISC_PACKAGE_MGRUSER}

COPY jdbc jdbc
COPY iris.script iris.script

RUN iris start IRIS \
	&& iris session IRIS < iris.script \
    && iris stop IRIS quietly
