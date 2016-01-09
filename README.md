build ruby debs in a docker container

```
# build the containers
docker build -t ruby-build-precise -f Dockerfile.precise .
docker build -t ruby-build-trusty -f Dockerfile.trusty .

# build the default 2.3.0 ruby and output the debs
docker run -it --rm -v /path/to/host/output/directory:/tmp/ruby-build/dist ruby-build-precise
docker run -it --rm -v /path/to/host/output/directory:/tmp/ruby-build/dist ruby-build-trusty

# override the environment variables to build ruby 2.2.2 and outut the debs
docker run -it --rm -v /path/to/host/output/directory:/tmp/ruby-build/dist \
-e "RUBY_PKG_VERSION=2.2" \
-e "RUBY_VERSION=2.2.2" \
ruby-build-precise

docker run -it --rm -v /path/to/host/output/directory:/tmp/ruby-build/dist \
-e "RUBY_PKG_VERSION=2.2" \
-e "RUBY_VERSION=2.2.2" \
ruby-build-trusty
```
