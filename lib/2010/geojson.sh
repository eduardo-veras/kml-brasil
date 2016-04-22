#!/usr/bin/env bash

# Bulk convert shapefiles to geojson using ogr2ogr
# Outputs as geojson with the crs:84 SRS (for use on GitHub or elsewhere)
# Assumes you have ogr2ogr installed
# Install it using:
# OSX: brew install gdal
# Ubuntu/Debian: sudo apt-get install gdal
# Arch: yaourt -S gdal

function kml2geojson() {
  ogr2ogr -f GeoJSON -t_srs crs:84 "$1.geojson" "$1.kml"
}

for file in `find . -name *.kml`
do
    kml2geojson ${file%\.*}
done

for folder in `find . -type d -name kml`
do
    mkdir ${folder%\kml}geojson
    mv ${folder}/*.geojson ${folder%\kml}geojson/
done
