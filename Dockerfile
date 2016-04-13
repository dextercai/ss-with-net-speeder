# shadowsocks-net-speeder

FROM ubuntu:14.04.3
MAINTAINER lowid <lowid@outlook.com>

RUN apt-get install libnet1 libnet1-dev libpcap0.8 libpcap0.8-dev -y
RUN git clone https://github.com/snooda/net-speeder.git
RUN sh build.sh

RUN mv net_speeder /usr/local/bin/
nohup net_speeder venet0 "ip" >/dev/null 2>&1 &

RUN apt-get update && \
    apt-get install -y python-pip
RUN pip install shadowsocks==2.8.2

# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/ssserver"]
