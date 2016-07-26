build ruby debs in a docker container

1. Make sure to update build.sh to add/remove the correct `--conflicts` and `--replaces` lines.
1. Set the `RUBY_PKG_ITERATION` and `RUBY_PKG_MAINTAINER` environment variables for your build.
1. Build the container(s) for the ubuntu release you want the ruby package to be build on.

```
# build the containers
docker build -t adamvduke/docker-ruby-build:precise -f precise/Dockerfile .
docker build -t adamvduke/docker-ruby-build:trusty -f trusty/Dockerfile .

# build the default 2.3.0 ruby and output the debs
docker run -it --rm -v /path/to/host/output/directory:/tmp/ruby-build/dist adamvduke/docker-ruby-build:precise
docker run -it --rm -v /path/to/host/output/directory:/tmp/ruby-build/dist adamvduke/docker-ruby-build:trusty

# override the environment variables to build ruby 2.2.2 and outut the debs
docker run -it --rm -v /path/to/host/output/directory:/tmp/ruby-build/dist \
-e "RUBY_PKG_VERSION=2.2" \
-e "RUBY_VERSION=2.2.2" \
adamvduke/docker-ruby-build:precise

docker run -it --rm -v /path/to/host/output/directory:/tmp/ruby-build/dist \
-e "RUBY_PKG_VERSION=2.2" \
-e "RUBY_VERSION=2.2.2" \
adamvduke/docker-ruby-build:trusty

# use dpkg --info to inspect the package that you built and make sure it looks correct
~$ docker run -it --rm -e RUBY_PKG_ITERATION=2 -e RUBY_PKG_MAINTAINER=adamduke@twitter.com -v ~/tmp/precise/dist:/tmp/ruby-build/dist adamvduke/docker-ruby-build:precise bash
root@4ca002d5435b:/# dpkg --info /tmp/ruby-build/dist/ruby2.3_2.3.0-2_amd64.deb
 new debian package, version 2.0.
 size 32744464 bytes: control archive= 36418 bytes.
     559 bytes,    15 lines      control
  106372 bytes,  1244 lines      md5sums
 Package: ruby2.3
 Version: 2.3.0-2
 License: 2-clause BSDL
 Vendor: ruby
 Architecture: amd64
 Maintainer: adamduke@twitter.com
 Installed-Size: 114330
 Depends: libc6 (>= 2.6), libffi6 (>= 3.0.10), libgdbm3 (>= 1.8.3), libncurses5 (>= 5.7), libreadline6 (>= 6.1), libssl1.0.0 (>= 1.0.0), libstdc++6 (>= 4.4.3), libyaml-0-2 (>= 0.1.3), zlib1g (>= 1:1.2.2)
 Conflicts: ruby1.9.1, ruby1.9.3, ruby2.1
 Provides: ruby, ruby-interpreter
 Replaces: ruby1.9.1, ruby1.9.3, ruby2.1
 Section: default
 Priority: extra
 Homepage: https://ruby-lang.org
 Description: Ruby 2.3.0 stable
root@4ca002d5435b:/# exit
exit
~$ docker run -it --rm -e RUBY_PKG_ITERATION=2 -e RUBY_PKG_MAINTAINER=adamduke@twitter.com -v ~/tmp/trusty/dist:/tmp/ruby-build/dist adamvduke/docker-ruby-build:trusty bash
root@74d487e05ac5:/# dpkg --info /tmp/ruby-build/dist/ruby2.3_2.3.0-2_amd64.deb
 new debian package, version 2.0.
 size 30693586 bytes: control archive=36422 bytes.
     559 bytes,    15 lines      control
  106372 bytes,  1244 lines      md5sums
 Package: ruby2.3
 Version: 2.3.0-2
 License: 2-clause BSDL
 Vendor: ruby
 Architecture: amd64
 Maintainer: adamduke@twitter.com
 Installed-Size: 102406
 Depends: libc6 (>= 2.6), libffi6 (>= 3.0.10), libgdbm3 (>= 1.8.3), libncurses5 (>= 5.7), libreadline6 (>= 6.1), libssl1.0.0 (>= 1.0.0), libstdc++6 (>= 4.4.3), libyaml-0-2 (>= 0.1.3), zlib1g (>= 1:1.2.2)
 Conflicts: ruby1.9.1, ruby1.9.3, ruby2.1
 Provides: ruby, ruby-interpreter
 Replaces: ruby1.9.1, ruby1.9.3, ruby2.1
 Section: default
 Priority: extra
 Homepage: https://ruby-lang.org
 Description: Ruby 2.3.0 stable
```
