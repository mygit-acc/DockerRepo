From 172.31.31.133:8124/dockerimages:tomcat
COPY target/*.war /usr/local/tomcat/webapps/myweb.war
