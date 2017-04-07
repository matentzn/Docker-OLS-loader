FROM maven:3-jdk-8

RUN echo Building OLS && \
git clone https://github.com/EBISPOT/OLS.git && \
cd OLS && \
mvn clean package

CMD ['/bin/bash']
