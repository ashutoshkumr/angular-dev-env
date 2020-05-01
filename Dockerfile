FROM ubuntu:20.04
ARG NODE_VERSION=12
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    curl                    \
    ca-certificates         \
    git                     \
    vim                     \
    iproute2                \
    #
    # install node
    && curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs                                            \
    #
    # install angular
    && npm install -g @angular/cli \
    && mkdir -p /home/app

COPY . /home/app
RUN cd /home && ng new app --defaults=true --force=true
WORKDIR /home/app
EXPOSE 4200
CMD ["/bin/bash"]