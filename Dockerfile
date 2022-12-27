FROM debian:11 

RUN apt update && apt upgrade -y
RUN apt install curl openssh-client python3 python3-pip -y
RUN pip3 install mysql-connector-python

WORKDIR /var/www/html
COPY webInterface /var/www/html/

# Copy the apache2 conf
# COPY website.conf /etc/apache2/site-enabled/000-default.conf

# Create a directory for the app
RUN mdkir /app
WORKDIR /app
COPY Advitising .
COPY checkProcesus .
COPY data .
COPY dataAccessCkecker .
COPY webInterface .
COPY start .

ARG SERVER_TO_CHECK_IP=0.0.0.0

# EXPOSE 80

CMD ./start $SERVER_TO_CHECK_IP

