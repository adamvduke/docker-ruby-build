#!/bin/bash

set -e

if [ "$1" = 'bash' ]; then
  exec "$@"
fi

# create the build dir
# and cd to it
cd $RUBY_BUILD_DIR

# download the ruby source gz
wget https://cache.ruby-lang.org/pub/ruby/$RUBY_PKG_VERSION/ruby-$RUBY_VERSION.tar.gz

# extract and build ruby
tar -zxvf ruby-$RUBY_VERSION.tar.gz
cd ruby*
rm -rf $RUBY_DESTDIR/usr
./configure --prefix=/usr \
            --disable-install-doc \
            --disable-install-rdoc \
            --with-destdir=$RUBY_DESTDIR && \
            make && \
            make install DESTDIR=$RUBY_DESTDIR

cd $RUBY_DESTDIR

# build a debian package
gem install fpm --no-ri --no-rdoc
fpm -s dir \
    -C $RUBY_DESTDIR \
    -t deb \
    --force \
    --name ruby$RUBY_PKG_VERSION \
    --version $RUBY_VERSION \
    --iteration $RUBY_PKG_ITERATION \
    --depends "libc6 (>= 2.6)" \
    --depends "libffi6 (>= 3.0.10)" \
    --depends "libgdbm3 (>= 1.8.3)" \
    --depends "libncurses5 (>= 5.7)" \
    --depends "libreadline6 (>= 6.1)" \
    --depends "libssl1.0.0 (>= 1.0.0)" \
    --depends "libstdc++6 (>= 4.4.3)" \
    --depends "libyaml-0-2 (>= 0.1.3)" \
    --depends "zlib1g (>= 1:1.2.2)" \
    --description "Ruby $RUBY_VERSION stable" \
    --license "2-clause BSDL" \
    --maintainer $RUBY_PKG_MAINTAINER \
    --provides ruby \
    --provides ruby-interpreter \
    --replaces ruby1.9.1 \
    --replaces ruby1.9.3 \
    --conflicts ruby1.9.1 \
    --conflicts ruby1.9.3 \
    --replaces ruby2.1 \
    --conflicts ruby2.1 \
    --url "https://ruby-lang.org" \
    --vendor ruby \
    usr/bin usr/lib usr/share usr/include

exec "$@"

