FROM node:16.19.1-alpine3.16
USER root
WORKDIR /code
RUN mkdir -p /code/build
RUN apk add git openssh-client mysql-client
RUN echo $(npm --version)
RUN echo $(yarn --version)
RUN mkdir /root/.ssh
RUN mkdir -p /root/.npm/_cacache/tmp
RUN mkdir -p /code/node_modules/.bin
ENV PATH="/code/node_modules/.bin:${PATH}"
