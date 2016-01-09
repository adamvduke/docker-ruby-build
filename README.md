build ruby debs in a docker container

```
# build the container
docker build -t ruby-build . &&

# build the default 2.3.0 ruby and output the deb
docker run -it --rm -v /path/to/host/output/file:/tmp/ruby-build/dist ruby-build

# explicitly build ruby 2.3.0 and output the deb
docker run -it --rm -v /path/to/host/output/file:/tmp/ruby-build/dist \
-e "RUBY_PKG_VERSION=2.3" \
-e "RUBY_VERSION=2.3.0" \
ruby-build bash

# override the environment variables to build ruby 2.2.2 and outut the deb
docker run -it --rm -v /path/to/host/output/file:/tmp/ruby-build/dist \
-e "RUBY_PKG_VERSION=2.2" \
-e "RUBY_VERSION=2.2.2" \
ruby-build bash
```
