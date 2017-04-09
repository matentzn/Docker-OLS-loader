FROM maven:3-jdk-8

ENV VFB_OWL_VERSION=Current

ENV WORKSPACE=/opt/VFB

ENV JAVA_OPTS='-Xmx20g -Xms10g'

VOLUME /data

RUN echo Building OLS && \
mkdir -p ${WORKSPACE} && \
cd ${WORKSPACE} && \
git clone https://github.com/VirtualFlyBrain/OLS_configs.git && \
git clone https://github.com/EBISPOT/OLS.git && \
cp ${WORKSPACE}/OLS_configs/*.properties ${WORKSPACE}/OLS/ols-apps/ols-neo4j-app/src/main/resources/ && \
cd ${WORKSPACE}/OLS && \
mvn clean package

RUN echo Building owltools && \
cd ${WORKSPACE} && \
git clone https://github.com/VirtualFlyBrain/owltools.git && \
cd ${WORKSPACE}/owltools && \
mvn install

COPY loadOLS.sh /opt/VFB/loadOLS.sh

RUN chmod +x /opt/VFB/loadOLS.sh

ENTRYPOINT ["/bin/bash -c /opt/VFB/loadOLS.sh"]
