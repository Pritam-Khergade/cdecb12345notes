FROM amazonlinux
RUN yum update &&yum install java-1.8.0-amazon-corretto.x86_64 -y
COPY tomcat8  /opt/tomcat
RUN chmod 777 /opt/tomcat/bin/*
EXPOSE 8080
CMD ["./opt/tomcat/bin/catalina.sh", "run" ]
