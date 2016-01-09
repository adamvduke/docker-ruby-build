FROM ubuntu:trusty

ENV RUBY_BUILD_DIR /tmp/ruby-build
ENV RUBY_DESTDIR $RUBY_BUILD_DIR/dist

RUN apt-get update && apt-get upgrade -y libapt-pkg4.12
RUN apt-get install -y wget build-essential openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev ncurses-dev libyaml-dev ruby-dev gcc

ENV RUBY_PKG_VERSION 2.3
ENV RUBY_VERSION 2.3.0

COPY build.sh $RUBY_BUILD_DIR/build.sh

ENTRYPOINT ["/tmp/ruby-build/build.sh"]