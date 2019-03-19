FROM nginx:stable-alpine

LABEL maintainer="amateur <amateur_hq@outlook.com>"

ARG ARIANG_VERSION=1.0.1

RUN  apk add --no-cache aria2 \
	&& adduser -D aria2 \
	&& mkdir /home/aria2/.aria2 \
	&& mkdir /home/aria2/Downloads \
	&& touch /home/aria2/.aria2/aria2.log \
	&& chown -R aria2:aria2 /home/aria2/.aria2 \
	&& chown -R aria2:aria2 /home/aria2/Downloads \
    && touch /var/run/nginx.pid \
    && chown -R aria2:aria2 /var/run/nginx.pid \
    && chown -R aria2:aria2 /var/cache/nginx \
	&& apk add --no-cache --virtual tools wget \
		unzip \
    && cd /usr/share/nginx/html \
	&& rm -rf * \
	&& wget -N https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VERSION}/AriaNg-${ARIANG_VERSION}.zip \
	&& unzip AriaNg-${ARIANG_VERSION}.zip \
	&& rm AriaNg-${ARIANG_VERSION}.zip \
	&& apk del tools

COPY --chown=aria2:aria2 ./resources/aria2.conf /home/aria2/.aria2/aria2.conf
COPY --chown=aria2:aria2 ./resources/start.sh /home/aria2/start.sh
COPY ./resources/default.conf /etc/nginx/conf.d/default.conf

VOLUME /home/aria2/Downloads

EXPOSE 8080
EXPOSE 6800

USER aria2

WORKDIR /home/aria2

ENV RPC_SECRET=MobyDick

CMD ["./start.sh"]
