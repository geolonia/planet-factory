#!/usr/bin/env bash

set -ex

TMPFILE=`mktemp`
TMPDIR=`mktemp -d`

curl -L "https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/physical/110m_physical.zip" -o $TMPFILE
unzip -d $TMPDIR $TMPFILE

find $TMPDIR -name "*.shp" -exec ogr2ogr -f GeoJSON {}.geojson {} \;
find $TMPDIR -name "*.geojson"

tippecanoe -z2 --extend-zooms-if-still-dropping --coalesce-densest-as-needed --force -o ocean.mbtiles $TMPDIR/ne_110m_ocean.shp.geojson