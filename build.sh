#!/bin/bash

# create the build dir
# and cd to it
cd $RUBY_BUILD_DIR

# download the ruby source gz
wget https://cache.ruby-lang.org/pub/ruby/$RUBY_PKG_VERSION/ruby-$RUBY_VERSION.tar.gz

# extract and build ruby
tar -zxvf ruby-$RUBY_VERSION.tar.gz
cd ruby*
rm -rf $RUBY_DESTDIR/usr
./configure --prefix=/usr --disable-install-doc --disable-install-rdoc --with-destdir=$RUBY_DESTDIR && make && make install

# build a debian package
gem install fpm --no-ri --no-rdoc
fpm -s dir -t deb -n ruby$RUBY_PKG_VERSION -v $RUBY_VERSION --description "Ruby $RUBY_VERSION stable" -C $RUBY_DESTDIR \
  -p $RUBY_DESTDIR/ruby$RUBY_PKG_VERSION-$UBUNTU_RELEASE-VERSION_ARCH.deb -d "libstdc++6 (>= 4.4.3)" \
  --replaces ruby2.1 --conflicts ruby2.1 \
  -d "libc6 (>= 2.6)" -d "libffi6 (>= 3.0.10)" -d "libgdbm3 (>= 1.8.3)" \
  -d "libncurses5 (>= 5.7)" -d "libreadline6 (>= 6.1)" \
  -d "libssl1.0.0 (>= 1.0.0)" -d "zlib1g (>= 1:1.2.2)" \
  -d "libyaml-0-2 (>= 0.1.3)" \
  usr/bin usr/lib usr/share usr/include

exec "$@"
