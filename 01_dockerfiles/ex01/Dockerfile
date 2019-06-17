FROM debian

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget bzip2

ENV TS3SERVER_LICENSE=accept

EXPOSE 9987/udp
EXPOSE 30033
EXPOSE 10011

RUN wget https://files.teamspeak-services.com/releases/server/3.8.0/teamspeak3-server_linux_amd64-3.8.0.tar.bz2
RUN tar -xvf teamspeak3-server_linux_amd64-3.8.0.tar.bz2
WORKDIR teamspeak3-server_linux_amd64

ENTRYPOINT sh ts3server_minimal_runscript.sh

