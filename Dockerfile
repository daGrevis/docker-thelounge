FROM alpine:3.3
MAINTAINER rgarrigue

# NodeJS, thanks to mhart/alpine-node  
ENV VERSION=v5.7.1 NPM_VERSION=3
# For base builds
# ENV CONFIG_FLAGS="--without-npm" RM_DIRS=/usr/include
# ENV CONFIG_FLAGS="--fully-static --without-npm" DEL_PKGS="libgcc libstdc++" RM_DIRS=/usr/include

RUN apk add --no-cache curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++ && \
  curl -sSL https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.gz | tar -xz && \
  cd /node-${VERSION} && \
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
  rm -rf /etc/ssl /node-${VERSION} ${RM_DIRS} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

# Create a non-root user for lounge to run in.
RUN adduser -D lounge

# Needed for Node.js' setup
ENV HOME /home/lounge

# Customize this to specify where The Lounge puts its data.
# To link a data container, have it expose /home/lounge/data
ENV LOUNGE_HOME /home/lounge

RUN npm install -g thelounge
 
# Expose HTTP
EXPOSE 9000

# Drop root
USER lounge

# Don't use an entrypoint here. It makes debugging difficult.
CMD lounge --home $LOUNGE_HOME
