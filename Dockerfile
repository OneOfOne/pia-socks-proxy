FROM alpine:latest
MAINTAINER Ahmed <OneOfOne> W.

EXPOSE 1080

COPY app /app
COPY etc /etc

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk --no-cache add openvpn dante-server runit \
	&& rm -rf /var/cache/ \
	chmod u+x /app/ovpn/run /app/sockd.sh

ENV REGION="" \
	USERNAME="" \
	PASSWORD=""

CMD ["runsvdir", "/app"]
