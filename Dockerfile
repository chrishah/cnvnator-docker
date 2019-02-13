FROM ubuntu:18.04

MAINTAINER <christoph.hahn@tugraz.at>

RUN apt-get update && apt-get -y upgrade && apt-get install -y build-essential vim git wget

WORKDIR /usr/src
#ROOT
RUN wget https://root.cern/download/root_v6.16.00.source.tar.gz
RUN tar xfz root_v6.16.00.source.tar.gz
RUN mkdir ROOT-builddir && cd ROOT-builddir && \
	apt-get install -y cmake libx11-xcb-dev libxpm-dev libxft-dev libxext-dev python python-dev && \
	cmake /usr/src/root-6.16.00/
RUN cd ROOT-builddir && \
	cmake --build .
#RUN /bin/bash -c "source /usr/src/ROOT-builddir/bin/thisroot.sh"
ENV ROOTSYS /usr/src/ROOT-builddir
ENV LD_LIBRARY_PATH /usr/src/ROOT-builddir/lib

#Samtools
RUN apt-get install -y libncurses5-dev libbz2-dev liblzma-dev && \
	wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
	tar jxf samtools-1.9.tar.bz2 && \
	cd samtools-1.9 && \
	./configure --prefix $(pwd) && \
	make && make install

#cnvnator
RUN git clone https://github.com/abyzovlab/CNVnator.git && \
	cd CNVnator && \
	ln -s /usr/src/samtools-1.9 samtools && \
	apt-get install -y libcurl3-dev && \
	make
ENV PATH="${PATH}:/usr/src/CNVnator/"
