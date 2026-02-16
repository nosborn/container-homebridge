FROM node:lts-slim@sha256:e8e2e91b1378f83c5b2dd15f0247f34110e2fe895f6ca7719dbb780f929368eb

USER 1000:1000
WORKDIR /app
COPY package-lock.json package.json /app/

RUN cd /app \
    && npm ci --omit dev --ignore-scripts --no-fund \
    && sed -i 's/this\.log\.info(`/this.log.debug(`/g' node_modules/homebridge-unifi-occupancy-lite/dist/platform.js

# EXPOSE 7878
VOLUME /data

ENTRYPOINT ["npx", "homebridge"]
CMD ["-Q", "-T", "-U", "/data"]
