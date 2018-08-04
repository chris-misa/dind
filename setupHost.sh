#!/bin/bash

#
# Set up dependencies for tools installed 
# at host-level in dind container

# Get dependencies for host system from deb
apt-get install -y libcap-dev libidn2-0-dev nettle-dev
apt-get install -y git gcc make

# Download and make iputils (which contains our version of ping)
git clone https://github.com/iputils/iputils.git
pushd iputils
make
popd

