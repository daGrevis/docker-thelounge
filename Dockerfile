FROM mhart/alpine-node:8.4
MAINTAINER daGrevis

ARG GIT_REV="master"

RUN apk add --no-cache openssh git

RUN apk add --no-cache make gcc g++ python && \
  git clone https://github.com/thelounge/lounge.git && \
  cd lounge && \
  git reset --hard $GIT_REV && \
  npm install && \
  npm run build && \
  apk del make gcc g++ python

WORKDIR /lounge

EXPOSE 9000
CMD npm run start
