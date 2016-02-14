FROM alpine:latest

# NodeJS, thanks to mhart/alpine-node  
ENV NODEJS_VERSION v5.6.0
ENV NPM_VERSION 3
ENV CONFIG_FLAGS "--fully-static"
ENV DEL_PKGS "libgcc libstdc++" 
ENV RM_DIRS /usr/include

RUN apk add --no-cache curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++ && \
  curl -sSL https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}.tar.gz | tar -xz && \
  cd /node-${NODEJS_VERSION} && \
  ./configure --prefix=/usr ${CONFIG_FLAGS} && \
  make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  make install && \
  paxctl -cm /usr/bin/node && \
  cd / && \
  if [ -x /usr/bin/npm ]; then \
    npm install -g npm@${NPM_VERSION} && \
    find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
  fi && \
  apk del curl make gcc g++ binutils-gold python linux-headers paxctl ${DEL_PKGS} && \
  rm -rf /etc/ssl /node-${NODEJS_VERSION} ${RM_DIRS} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

# The Lounge
RUN npm install -g thelounge
ENV LOUNGE_HOME /srv
 
# Expose HTTP
EXPOSE 9000

# Don't use an entrypoint here. It makes debugging difficult.
CMD lounge --home $LOUNGE_HOME
