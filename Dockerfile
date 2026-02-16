FROM node:lts-slim@sha256:a81a03dd965b4052269a57fac857004022b522a4bf06e7a739e25e18bce45af2

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
