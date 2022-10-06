FROM debian:bullseye

# # which spack version are we using now? Default is develop
# # but other strings can be given to the docker build command
# # (for example docker build --build-arg SPACK_VERSION=v0.16.2)
ARG SPACK_VERSION=develop
RUN echo "Building with spack version ${SPACK_VERSION}"

# Allow to build multiple versions of OOMMF with the same spack
# support libraries:
ARG OOMMF1_VERSION=oommf
ARG OOMMF2_VERSION=oommf
RUN echo "Installing ${OOMMF1_VERSION} and ${OOMMF2_VERSION}"

# Any extra packages to be installed in the host
ARG EXTRA_PACKAGES
RUN echo "Installing EXTRA_PACKAGES ${EXTRA_PACKAGES} on container host"

# general environment for docker
ENV SPACK_ROOT=/home/user/spack \
	  SPACK=/home/user/spack/bin/spack \
    FORCE_UNSAFE_CONFIGURE=1

RUN apt-get -y update
# Convenience tools
# RUN apt-get -y install wget time nano vim emacs git

# Does autoremove break the compilation?
RUN apt autoremove -y
#
# From https://github.com/ax3l/dockerfiles/blob/master/spack/base/Dockerfile:
# install minimal spack dependencies
RUN        apt-get install -y --no-install-recommends \
              autoconf \
              build-essential \
              ca-certificates \
              coreutils \
              curl \
              environment-modules \
              file \
              gfortran \
              git \
              openssh-server \
              python \
              unzip \
              vim \
           && rm -rf /var/lib/apt/lists/*

# load spack environment on login
RUN echo "source $SPACK_ROOT/share/spack/setup-env.sh" \
           > /etc/profile.d/spack.sh

# # OOMMF cannot be built as root user.
RUN adduser user
USER user
WORKDIR /home/user

# install spack
RUN git clone https://github.com/spack/spack.git
# default branch is develop
RUN cd spack && git checkout $SPACK_VERSION

# # show which version we use
RUN $SPACK --version

# build OOMMF

# on more recent spack versions (>=0.18 the least), oommf is already included
# RUN mkdir $SPACK_ROOT/var/spack/repos/builtin/packages/oommf

# in general, we want to test the 'oommf/package.py' file in this repository, so
# let's take it to override the one that comes with spack:
COPY spack/package.py $SPACK_ROOT/var/spack/repos/builtin/packages/oommf

# now build oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack spec $OOMMF1_VERSION
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack spec $OOMMF2_VERSION
# build tk separately - used to be a common reason for problems
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install tk
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install $OOMMF1_VERSION
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install $OOMMF2_VERSION

# # Run spack smoke tests for oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack test run --alias oommftest oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack test results -l oommftest 

# Run OOMMF example in container
RUN mkdir mif-examples
COPY --chown=user:user mif-examples/* mif-examples/
RUN ls -l mif-examples
# Run example simulations
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack load $OOMMF1_VERSION && oommf.tcl boxsi +fg -kill all mif-examples/stdprob3.mif
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack load $OOMMF2_VERSION && oommf.tcl boxsi +fg -kill all mif-examples/stdprob3.mif

CMD /bin/bash -l

