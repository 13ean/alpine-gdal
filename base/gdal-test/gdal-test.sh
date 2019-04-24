#!/bin/sh
set -e

echo "--- Test GDAL installation ---"

printf "it should find gdalinfo... "
gdalinfo --version > /dev/null
echo ok

#printf "it should find proj... "
#proj > /dev/null
#echo ok

#printf "it should compile gdal-test.cpp source... "
#g++ gdal-test.cpp -lgdal -o gdal-test > /dev/null
#echo ok

#printf "it should run gdalwarp program successfully... "
#/tmp/gdal-src/gdal-2.3.0/apps/gdalwarp -t_srs "+proj=UTM +zone=11" ./001.tif  out.tif > /dev/null
#echo ok
