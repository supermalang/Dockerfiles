#!/bin/sh

set -e # fail on any error


# Versions
# ===================================================================
GEOS_VERSION=3.4.3
PROJ_VERSION=7.2.0
#PROJ_DATUMGRID_VERSION=1.5 # Deprecated since proj7
GDAL_VERSION=3.2.0


# Install geos
# ===================================================================
cd /tmp
wget http://download.osgeo.org/geos/geos-${GEOS_VERSION}.tar.bz2
tar xjf geos-${GEOS_VERSION}.tar.bz2
cd geos-${GEOS_VERSION}
./configure --enable-silent-rules CFLAGS="-D__sun -D__GNUC__"  CXXFLAGS="-D__GNUC___ -D__sun -Wno-deprecated"
#make -s
#make -s install
make && make install

# Install proj
# ===================================================================
cd /tmp
wget http://download.osgeo.org/proj/proj-${PROJ_VERSION}.tar.gz
#wget http://download.osgeo.org/proj/proj-datumgrid-${PROJ_DATUMGRID_VERSION}.tar.gz
tar xzf proj-${PROJ_VERSION}.tar.gz
# Deprecated
#cd proj-${PROJ_VERSION}/nad
#tar xzf ../../proj-datumgrid-${PROJ_DATUMGRID_VERSION}.tar.gz
#cd ..
cd proj-${PROJ_VERSION}
./configure --enable-silent-rules
#make -s
#make -s install
make && make install

# Install gdal
# ===================================================================
cd /tmp
wget http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz
tar xzf gdal-${GDAL_VERSION}.tar.gz
cd gdal-${GDAL_VERSION}
#./configure --enable-silent-rules --with-static-proj4=/usr/local/lib
./configure --enable-silent-rules --with-proj=/usr/local
#make -s
#make -s install
make clean && make && make install
# Set LD_LIBRARY_PATH so that recompiled GDAL is used
export LD_LIBRARY_PATH=/usr/local/lib

# Clean up
# ===================================================================
rm -rf /tmp/*
rm -rf /root/.cache
