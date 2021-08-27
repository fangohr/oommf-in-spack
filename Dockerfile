FROM debian:bullseye

RUN apt-get -y update
# Convenience tools
RUN apt-get -y install wget time nano vim emacs git

# tools that spack needs
RUN apt-get -y install python curl git make patch zstd tar gzip unzip bzip2 gcc g++

# Does having tk and tcl available make a difference?
RUN apt-get -y install tk-dev tcl-dev
# OOMMF cannot be built as root user.
RUN adduser user
USER user
WORKDIR /home/user

# install spack
RUN git clone https://github.com/spack/spack.git
# default branch is develop
RUN cd spack && git checkout develop

# show which version we use
RUN cd spack && git show

RUN mkdir spack/var/spack/repos/builtin/packages/oommf
COPY spack/package.py spack/var/spack/repos/builtin/packages/oommf
RUN . spack/share/spack/setup-env.sh && spack install tk
RUN . spack/share/spack/setup-env.sh && spack install oommf

# if the above fails, we get some more details by repeatid
# the last command:
RUN . spack/share/spack/setup-env.sh && spack install --verbose oommf

# Run spack smoke tests
RUN . spack/share/spack/setup-env.sh && spack test run --alias oommftest oommf
RUN . spack/share/spack/setup-env.sh && spack test result -l oommftest 

# Run OOMMF example in container
# RUN mkdir mif-examples
# COPY mif-examples/* mif-examples
# 
# RUN . spack/share/spack/setup-env.sh && spack load oommf && oommf.tcl boxsi +fg mif-examples/stdprob3.mif -exitondone 1" 

CMD /bin/bash

