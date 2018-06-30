FROM alpine:3.6

ENV USERNAME=none
ENV PASSWORD=none
ENV XMLTV_FILENAME=xmltv.xml
ENV OPT_ARGS=

# Wait 12 Hours after run
ENV SLEEPTIME=43200

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "@edgetesting http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache perl@edge perl-html-parser@edge perl-http-cookies@edge perl-lwp-useragent-determined@edge perl-json@edge perl-json-xs@edgetesting
RUN apk add --no-cache perl-lwp-protocol-https@edge perl-uri@edge ca-certificates@edge perl-net-libidn@edge perl-net-ssleay@edge perl-io-socket-ssl@edge perl-libwww@edge perl-mozilla-ca@edge perl-net-http@edge

VOLUME /data
ADD zap2xml.pl /zap2xml.pl
ADD entry.sh /entry.sh
RUN chmod 755 /entry.sh /zap2xml.pl

CMD ["/entry.sh"]
