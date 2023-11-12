FROM ubuntu:22.04 as base

RUN apt-get -y update
RUN apt-get -y install git help2man perl make autoconf flex bison ccache python3
RUN apt-get -y install libgoogle-perftools-dev numactl perl-doc
RUN apt-get -y install libfl2 libfl-dev
RUN apt-get -y install g++ gcc-10 libfindbin-libs-perl

# Install Verilator
FROM base as verilator
RUN mkdir -p source && cd source \
    && git clone https://github.com/verilator/verilator \
    && cd verilator \
    && autoconf && ./configure && make -j `nproc` \
    && make install
RUN rm -rf source

# Install Modelsim
FROM verilator as questa
RUN dpkg --add-architecture i386 
RUN apt-get update 
RUN apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32ncurses6 libxft2 libxft2:i386 libxext6 libxext6:i386 \
    && apt-get -y install wget 
RUN mkdir -p source && cd source \
    && wget https://cdrdv2.intel.com/v1/dl/getContent/750637/750641?filename=ModelSimSetup-20.1.0.711-linux.run -O Modelsim-20.1-linux.run\
    && chmod +x ./Modelsim-20.1-linux.run \
    && ./Modelsim-20.1-linux.run --mode unattended --accept_eula 1 --installdir /opt/intelFPGA/20.1 
RUN rm -rf source 
ENV PATH="/opt/intelFPGA/20.1/modelsim_ase/bin:${PATH}"
