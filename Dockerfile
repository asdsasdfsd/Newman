FROM node:16-alpine

ARG NEWMAN_VERSION=5.3.0
ENV BASE_URL=http://smart_cart_api_server.tfk3s.ezey.link:38000

ENV LC_ALL="en_US.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

RUN if [ ! $(echo $NEWMAN_VERSION | grep -oE "^[0-9]+\.[0-9]+\.[0-9]+$") ]; then \
        echo "\033[0;31mA valid semver Newman version is required in the NEWMAN_VERSION build-arg\033[0m"; \
        exit 1; \
    fi && \
    npm install --global newman@${NEWMAN_VERSION} && \
    apk add --no-cache jq

WORKDIR /etc/newman

COPY my_collection.json .

ENTRYPOINT ["sh", "-c", "newman run my_collection.json --env-var baseUrl=$BASE_URL $0 $@"]

CMD []