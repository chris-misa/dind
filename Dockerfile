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

# Add script to install 'native' tools (just iputils for now)
COPY ./setupHost.sh /local/repository/setupHost.sh
RUN /local/repository/setupHost.sh

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]

