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
RUN apt-get -y install cpp

# Install compiler so spack can compile a compiler
RUN apt-get -y install gcc-8 g++-8

RUN apt-get -y install cpp

# OOMMF cannot be built as root user.
RUN adduser user
USER user
WORKDIR /home/user

# Fetch OOMMF
#RUN wget https://math.nist.gov/oommf/dist/oommf20a2_20200608-hotfix.tar.gz
#RUN tar xfz oommf20a2_20200608-hotfix.tar.gz
# WORKDIR /home/user/oommf

# install spack
RUN echo "Hello"
RUN git clone https://github.com/fangohr/spack.git

RUN cd spack && git checkout v0.16-add-oommf
RUN cd spack && bin/spack install gcc@10.2.0
RUN spack/bin/spack compiler find /home/user/spack/opt/spack/linux-debian10-haswell/gcc-8.3.0/gcc-10.2.0-*
RUN cd spack && bin/spack install tcl %gcc@10.2.0
RUN cd spack && bin/spack install tk %gcc@10.2.0
ADD set-up-oommf.sh /home/user
RUN bash set-up-oommf.sh
CMD /bin/bash
#RUN . spack/share/spack/setup-env.sh && spack env create oommf
#RUN . spack/share/spack/setup-env.sh && spack env activate oommf 
#RUN . spack/share/spack/setup-env.sh && spack env activate oommf && spack install gcc 
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

ADD set-up-oommf.sh /home/user
CMD /bin/bash
# 
