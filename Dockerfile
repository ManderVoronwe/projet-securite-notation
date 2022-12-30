FROM node:18-bullseye

RUN apt update && apt upgrade -y
RUN apt install curl openssh-client python3 python3-pip -y
RUN pip3 install mysql-connector-python


# Create a directory for the app
RUN mkdir -p /app
WORKDIR /app
COPY . .


#ARG SERVER_IP=0.0.0.0
ENV ENV_SERVER_IP=0.0.0.0


# Go in the app folder
WORKDIR /app/webInterface
RUN npm install
RUN npm install chart.js
RUN npm install --save-dev parcel


EXPOSE 1234
RUN chmod 777 /app/webInterface/start
RUN chmod 777 /app/datascript
RUN chmod -R 777 /app

CMD ["./start"]