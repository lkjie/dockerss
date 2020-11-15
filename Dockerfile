# Dockerfile for ShadowsocksR based alpine
# Copyright (C) 2018 - 2019 Teddysun <i@teddysun.com>
# Reference URL:
# https://github.com/shadowsocksrr/shadowsocksr

FROM python:3.7-alpine
LABEL maintainer="Teddysun <i@teddysun.com>"

RUN set -ex \
	&& apk add --no-cache tar libsodium-dev openssl \
	&& wget -O /tmp/shadowsocksr-3.2.2.tar.gz https://github.com/shadowsocksrr/shadowsocksr/archive/3.2.2.tar.gz \
	&& tar zxf /tmp/shadowsocksr-3.2.2.tar.gz -C /tmp \
	&& mv /tmp/shadowsocksr-3.2.2/shadowsocks /usr/local/ \
	&& rm -fr /tmp/shadowsocksr-3.2.2 \
	&& rm -f /tmp/shadowsocksr-3.2.2.tar.gz

COPY ./config_sample.json /etc/shadowsocks-r/config.json
VOLUME /etc/shadowsocks-r

CMD [ "/usr/local/shadowsocks/server.py", "-c", "/etc/shadowsocks-r/config.json" ]
