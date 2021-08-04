FROM ruby:3.0.2-alpine3.14

RUN \
  adduser -D -u 1000 -s /bin/false -g '' ruby && \
  mkdir /usr/run && \
  chown ruby /usr/run

WORKDIR /usr/run
USER ruby
