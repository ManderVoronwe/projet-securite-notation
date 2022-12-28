FROM node:18-bullseye

RUN apt update && apt upgrade -y
RUN apt install curl openssh-client python3 python3-pip -y
RUN pip3 install mysql-connector-python


# Create a directory for the app
RUN mdkir /app
WORKDIR /app
COPY . .

ARG SERVER_TO_CHECK_IP=0.0.0.0

# Go in the app folder
WORKDIR /app/webInterface
RUN npm install

EXPOSE 8080

CMD ["./start", "$SERVER_TO_CHECK_IP"]

