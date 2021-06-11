FROM tomcat:8.0
MAINTAINER reddydinesh
COPY **/*.war /usr/local/tomcat/webapps/
