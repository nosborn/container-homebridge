FROM node:24.19.0-slim

USER 1000:1000
WORKDIR /app
COPY package-lock.json package.json /app/

RUN npm ci --omit dev --ignore-scripts --no-fund \
    && sed -i 's/this\.log\.info(/this.log.debug(/g' node_modules/homebridge-unifi-occupancy-lite/dist/platform.js

# EXPOSE 7878
VOLUME /data

ENTRYPOINT ["npx", "homebridge"]
CMD ["-Q", "-T", "-U", "/data"]
