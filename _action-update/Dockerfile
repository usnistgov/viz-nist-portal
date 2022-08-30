FROM node:12-stretch

LABEL "com.github.actions.name"="Run Vue build and deploy"
LABEL "com.github.actions.description"="Run the complete CI/CD pipeline"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/usnistgov/viz-nist-portal"
LABEL "homepage"="https://usnistgov.github.io/viz-nist-portal"

RUN apt-get update && apt-get install \
    -y --no-install-recommends curl git

COPY hub-linux-amd64-2.12.4.tgz /hub-linux-amd64-2.12.4.tgz
RUN tar -zxf /hub-linux-amd64-2.12.4.tgz -C / && rm /hub-linux-amd64-2.12.4.tgz
RUN /hub-linux-amd64-2.12.4/install

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
