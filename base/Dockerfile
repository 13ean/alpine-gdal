FROM nlknguyen/alpine-mpich:latest
# In case the main package repositories are down, use the alternative base image:
# FROM nlknguyen/alpine-mpich:latest

MAINTAINER Zhaobin Cao

USER root
ARG REQUIRE="sudo build-base"
RUN apk update && apk upgrade \
	&& apk add linux-headers \
	&& apk add --update ca-certificates openssl && update-ca-certificates \
  && apk add --no-cache ${REQUIRE}


#### INSTALL MPICH ####
# Source is available at http://www.mpich.org/static/downloads/

# Build Options:
# See installation guide of target MPICH version
# Ex: http://www.mpich.org/static/downloads/3.2/mpich-3.2-installguide.pdf
# These options are passed to the steps below
ARG MPICH_CONFIGURE_OPTIONS="--prefix=/usr/local --disable-fortran"

# Download, build, and install MPICH
#RUN mkdir /tmp/mpich-src
#WORKDIR /tmp/mpich-src
#COPY mpich-3.3.tar.gz .
#RUN wget http://www.mpich.org/static/downloads/3.3/mpich-3.3.tar.gz \
#RUN tar xfz mpich-3.3.tar.gz  \
#  && cd mpich-3.3  \
#  && ./configure ${MPICH_CONFIGURE_OPTIONS}  \
#  && make -j4 \
#	&& make install


### Install GEOS
ARG GEOS_CONFIGURE_OPTIONS="--prefix=/usr/local"

RUN mkdir /tmp/geos-src
WORKDIR /tmp/geos-src
RUN wget https://download.osgeo.org/geos/geos-3.6.2.tar.bz2 \
  && tar xjf geos-3.6.2.tar.bz2 \
  && cd geos-3.6.2 \
  && ./configure ${GEOS_CONFIGURE_OPTIONS}\
  && make -j4\
  && make install


### Install PROJ
ARG PROJ_CONFIGURE_OPTIONS="--prefix=/usr/local"

RUN mkdir /tmp/proj-src
WORKDIR /tmp/proj-src
RUN wget http://download.osgeo.org/proj/proj-5.0.1.tar.gz \
  && tar zxf proj-5.0.1.tar.gz \
  && cd proj-5.0.1 \
  && ./configure ${PROJ_CONFIGURE_OPTIONS} \
  && make -j4\
  && make install


### Install GDAL
ARG GDAL_CONFIGURE_OPTIONS="--prefix=/usr/local --with-proj=/usr/local --with-geos=/usr/local"

RUN mkdir /tmp/gdal-src
WORKDIR /tmp/gdal-src
RUN wget http://download.osgeo.org/gdal/2.3.0/gdal-2.3.0.tar.gz \
  && tar zxf gdal-2.3.0.tar.gz \
  && cd gdal-2.3.0 \
  && ./configure ${GDAL_CONFIGURE_OPTIONS} \
  && make -j4 \
  && make install

### Test GDAL
RUN mkdir /tmp/gdal-test
WORKDIR /tmp/gdal-test
COPY gdal-test .
RUN sh gdal-test.sh


### TEST MPICH INSTALLATION ####
RUN mkdir /tmp/mpich-test
WORKDIR /tmp/mpich-test
COPY mpich-test .
RUN sh test.sh


#### CLEAN UP ####
WORKDIR /
RUN rm -rf /tmp/*


# switch to default user and workdir
ARG USER=mpi
ARG WORKDIR=/project
WORKDIR ${WORKDIR}
USER ${USER}
