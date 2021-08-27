FROM debian:bullseye

# general environment for docker
#ENV        DEBIAN_FRONTEND=noninteractive \
ENV        SPACK_ROOT=/home/user/spack \
	   SPACK=/home/user/spack/bin/spack \
           FORCE_UNSAFE_CONFIGURE=1

RUN apt-get -y update
# Convenience tools
RUN apt-get -y install wget time nano vim emacs git

# Fool container into providing everything needed for X (Robert's idea)
# RUN apt-get -y install x11-apps

# Does it help to use the system tk (suspicous obversation in spack built on host)
RUN apt-get -y install tcl-dev tk-dev

# From https://github.com/ax3l/dockerfiles/blob/master/spack/base/Dockerfile:
# install minimal spack depedencies
RUN        apt-get update \
           && apt-get install -y --no-install-recommends \
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




# tools that spack needs (Hans' original list)
# RUN apt-get -y install python curl git make patch zstd tar gzip unzip bzip2 gcc g++

# load spack environment on login
RUN echo "source $SPACK_ROOT/share/spack/setup-env.sh" \
           > /etc/profile.d/spack.sh


# # OOMMF cannot be built as root user.
RUN adduser user
USER user
WORKDIR /home/user


# install spack
RUN mkdir $SPACK_ROOT
RUN        curl -s -L https://github.com/llnl/spack/archive/develop.tar.gz \
           | tar xzC $SPACK_ROOT --strip 1
# note: at this point one could also run ``spack bootstrap`` to avoid
#       parts of the long apt-get install list above

# install software
RUN        $SPACK install tar \
           && $SPACK clean -a

# need the modules already during image build?
#RUN        /bin/bash -l -c ' \
#                $SPACK load tar \
#                && which tar'

# 
# 
# # install spack
# RUN git clone https://github.com/spack/spack.git
# # default branch is develop
# RUN cd spack && git checkout develop
# 
# # show which version we use
RUN $SPACK --version
#
CMD /bin/bash -l


RUN mkdir $SPACK_ROOT/var/spack/repos/builtin/packages/oommf
COPY spack/package.py $SPACK_ROOT/var/spack/repos/builtin/packages/oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack spec oommf
#RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install tk
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack install oommf
# 
# # Run spack smoke tests
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack test run --alias oommftest oommf
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack test results -l oommftest 
# 



# Run OOMMF example in container
RUN mkdir mif-examples
COPY mif-examples/* mif-examples/
# # 
RUN . $SPACK_ROOT/share/spack/setup-env.sh && spack load oommf && oommf.tcl boxsi +fg mif-examples/stdprob3.mif -exitondone 1
# 
CMD /bin/bash -l


