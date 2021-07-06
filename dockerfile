From 52.66.232.163:8124/dockerimages:alpine
RUN apk add openjdk8
WORKDIR /opt
RUN wget https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.68/bin/apache-tomcat-8.5.68.tar.gz
RUN tar xf apache-tomcat-8.5.68.tar.gz
RUN mv apache-tomcat-8.5.68 tomcat8
EXPOSE 8080
CMD ["/opt/tomcat8/bin/catalina.sh","run"]
