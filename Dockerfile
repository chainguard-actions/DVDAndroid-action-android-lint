FROM alpine:3.11

RUN apk --no-cache --update add git python3 \
    && rm -rf /var/cache/apk/*

RUN wget -q -O /tmp/install-reviewdog.sh https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh \
    && sh /tmp/install-reviewdog.sh \
    && rm /tmp/install-reviewdog.sh

COPY entrypoint.sh /entrypoint.sh
COPY converter.py /usr/local/bin/converter.py

ENTRYPOINT ["/entrypoint.sh"]
