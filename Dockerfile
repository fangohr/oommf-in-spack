FROM debian:bullseye

# # which spack version are we using now? Default is develop
# # but other strings can be given to the docker build command
# # (for example docker build --build-arg SPACK_VERSION=v0.16.2)
ARG SPACK_VERSION=develop
RUN echo "Building with spack version ${SPACK_VERSION}"

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

RUN apt list --installed > packages-before.txt
RUN apt-get -y install ${EXTRA_PACKAGES} x11proto-dev
RUN apt remove -y ${EXTRA_PACKAGES}
RUN apt list --installed > packages-after.txt

# Does autoremove break the compilation?
# RUN apt autoremove -y


# at this point, we do not depend on ${EXTRA_PACKAGES}, but maybe on dependencies of
# of those?
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

# # install spack
# RUN mkdir $SPACK_ROOT
# RUN        curl -s -L https://github.com/llnl/spack/archive/develop.tar.gz \
#            | tar xzC $SPACK_ROOT --strip 1
# note: at this point one could also run ``spack bootstrap`` to avoid
#       parts of the long apt-get install list above


#
# install spack
RUN git clone https://github.com/spack/spack.git
# default branch is develop
RUN cd spack && git checkout $SPACK_VERSION

# # show which version we use
RUN $SPACK --version
#

# build OOMMF
RUN mkdir $SPACK_ROOT/var/spack/repos/builtin/packages/oommf
COPY spack/package.py $SPACK_ROOT/var/spack/repos/builtin/packages/oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack spec oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install tk
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install oommf

# # Run spack smoke tests for oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack test run --alias oommftest oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack test results -l oommftest 

# Run OOMMF example in container
RUN mkdir mif-examples
COPY --chown=user:user mif-examples/* mif-examples/
RUN ls -l mif-examples
# # 
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack load oommf && oommf.tcl boxsi +fg mif-examples/stdprob3.mif -exitondone 1

# Show that we do not depend on debian package tk-dev for execution of OOMMF

# USER root
# RUN apt emove -y ${EXTRA_PACKAGES}
# USER user
# RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack load oommf && oommf.tcl boxsi +fg mif-examples/stdprob3.mif -exitondone 1

CMD /bin/bash -l

