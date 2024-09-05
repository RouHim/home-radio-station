####################
#    Run Image     #
####################
FROM docker.io/ubuntu:24.04
LABEL maintainer="Rouven Himmelstein rouven@himmelstein.info"
ENV RSAS_URL "https://rocketbroadcaster.com/streaming-audio-server/downloads/ubuntu-24.04/rsas_1.0.5-1_amd64.deb"

## Game server parameter and their defaults
ENV TZ "UTC"

# Install game server required packages
RUN apt update &&  \
    apt upgrade -y && \
    apt install -y libogg0 adduser openssl && \
    apt-get clean &&  \
    rm -rf /var/lib/apt/lists/

# Download and install rsas
ADD $RSAS_URL /rsas.deb
RUN dpkg -i /rsas.deb && \
    rm /rsas.deb

# Copy default config
RUN mv /etc/rsas/rsas.xml.example_simple /etc/rsas/rsas.xml

RUN chown -R rsas:rsas \
     /usr/bin/rsas \
     /etc/rsas \
     /usr/share/rsas

USER rsas

# Specify entrypoint
ENTRYPOINT ["/usr/bin/rsas", "-c", "/etc/rsas/rsas.xml"]