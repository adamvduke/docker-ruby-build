build ruby debs in a docker container

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
```
