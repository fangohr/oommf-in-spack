FROM bitnami/minideb:buster
RUN /bin/bash

# Avoid asking for geographic data when installing tzdata.
# ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y install wget 
# Convenience for debugging
RUN apt-get -y install time nano

# tools that spack needs
RUN apt-get -y install python curl git make patch  zstd tar gzip unzip bzip2 #xz?

# Install compiler so spack can compile a compiler
RUN apt-get -y install gcc-8 g++-8

# RUN apt-get -y install gcc-8 g++-8

# OOMMF cannot be built as root user.
RUN adduser user
USER user
WORKDIR /home/user

# Fetch OOMMF
RUN wget https://math.nist.gov/oommf/dist/oommf20a2_20200608-hotfix.tar.gz
RUN tar xfz oommf20a2_20200608-hotfix.tar.gz
# WORKDIR /home/user/oommf

# install spack
RUN git clone https://github.com/spack/spack.git
CMD /bin/bash

RUN . spack/share/spack/setup-env.sh && spack env create oommf
RUN . spack/share/spack/setup-env.sh && spack env activate oommf 
RUN . spack/share/spack/setup-env.sh && spack env activate oommf && spack install gcc 
#RUN . spack/share/spack/setup-env.sh && spack env activate oommf && spack install tcl tk 
# RUN source spack/share
# 
# 
# 
# 
# # Compile OOMMF according to Readme
# RUN ./oommf.tcl pimake +platform > pimake-platform-output.txt
# RUN ./oommf.tcl pimake distclean
# RUN ./oommf.tcl pimake upgrade
# RUN ./oommf.tcl pimake
# 
# # Create test:
# RUN echo "time tclsh oommf.tcl boxsi +fg app/oxs/examples/stdprob3.mif -exitondone 1" > run-test.sh
# # execute test (takes about 14 seconds on 2 threads)
# RUN sh test-oommf.sh
# 
CMD /bin/bash
# 
