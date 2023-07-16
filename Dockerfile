FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
 && apt install -y curl net-tools uml-utilities bridge-utils sudo \
 	libsdl2-2.0-0 libnuma1 libaio1 \
 && curl -o /install.deb https://upload-cdn.huami.com/zeppos/simulator/download/simulator_1.2.1_amd64.deb \
 && apt install -y /install.deb \
 && rm /install.deb \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf var/cache/apt/*

ENV HOME=/home/simulator/

RUN useradd -m -s /bin/bash simulator \
 && chmod 4755 /opt/simulator/chrome-sandbox \
 && chown -R simulator:simulator /home/simulator 
RUN echo 'simulator ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER simulator
CMD ["/opt/simulator/simulator"]