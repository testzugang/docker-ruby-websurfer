FROM ruby:2.3.0-slim

RUN set -x \
    && apt-get update \
    && apt-get install -y wget libfontconfig1 ruby-dev zlib1g-dev liblzma-dev build-essential git expect-dev \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz --no-check-certificate --quiet -O /tmp/s6-overlay.tar.gz \
    && tar xvfz /tmp/s6-overlay.tar.gz -C / \
    && rm -f /tmp/s6-overlay.tar.gz \    
    && echo 'gem: --no-document' >> ~/.gemrc \
    && gem install nokogiri -v '~> 1.8' \
    && gem install mail -v '~> 2.5.4' \
    && gem install mechanize \
    && gem install zaru

WORKDIR /usr/app

COPY run.sh /
ENTRYPOINT ["/run.sh"]