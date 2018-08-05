FROM ubuntu:18.04
MAINTAINER jerome.petazzoni@docker.com

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Copy in some config files for docker and ndppd
RUN mkdir -p /etc/docker
COPY ./config/daemon.json /etc/docker/daemon.json
COPY ./config/ndppd.conf /etc/ndppd.conf

# Add script to set up container for testing
COPY ./setupHost.sh /local/repository/setupHost.sh
RUN /local/repository/setupHost.sh

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]

