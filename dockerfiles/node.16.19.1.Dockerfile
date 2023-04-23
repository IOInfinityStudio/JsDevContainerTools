FROM node:16.19.1
USER root
WORKDIR /code
RUN mkdir -p /code/build
RUN apt-get update && apt-get install -y git openssh-client default-mysql-client 
RUN echo $(node --version)
RUN echo $(npm --version)
RUN mkdir /root/.ssh
RUN mkdir -p /root/.npm/_cacache/tmp
RUN mkdir -p /code/node_modules/.bin
ENV PATH="/code/node_modules/.bin:${PATH}"