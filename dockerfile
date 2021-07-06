From 15.206.202.35:8124/dockerimages:tomcat
COPY target/*.war /usr/local/tomcat/webapps/myweb.war
