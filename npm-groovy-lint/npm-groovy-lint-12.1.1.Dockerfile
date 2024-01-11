FROM node:21.2.0-bullseye
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk-headless openjdk-17-jre-headless && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
RUN npm install -g npm-groovy-lint@12.1.1
