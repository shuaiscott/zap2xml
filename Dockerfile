FROM alpine:3

ENV USERNAME=none
ENV PASSWORD=none
ENV OPT_ARGS=

ENV USERNAME2=none
ENV PASSWORD2=none
ENV OPT_ARGS2=

ENV XMLTV_FILENAME=xmltv.xml

# Wait 12 Hours after run
ENV SLEEPTIME=43200

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk add --no-cache perl perl-dev gcc make musl-dev wget curl perl-json perl-app-cpanminus openssl perl-io-socket-ssl
RUN cpanm --force --reinstall JSON::XS
RUN cpanm --force --reinstall Compress::Raw::Zlib
RUN apk add --no-cache perl-html-parser@edge perl-http-cookies@edge \
                       perl-lwp-useragent-determined@edge \
                       perl-lwp-protocol-https@edge perl-uri@edge ca-certificates@edge \
                       perl-net-libidn@edge perl-io-socket-ssl@edge \
                       perl-libwww@edge perl-mozilla-ca@edge perl-net-http@edge
RUN apk add --no-cache xmltv@edge

VOLUME /data
ADD zap2xml.pl /zap2xml.pl
ADD entry.sh /entry.sh
RUN chmod 755 /entry.sh /zap2xml.pl

CMD ["/entry.sh"]
