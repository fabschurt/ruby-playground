FROM ruby:3.2.2-alpine3.18

RUN \
  adduser -D -u 1000 -s /sbin/nologin -g '' ruby && \
  mkdir /home/ruby/run

WORKDIR /home/ruby/run
USER ruby
