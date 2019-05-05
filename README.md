# Planet Factory

An development environment for Mapbox GL based vector tiles.

## What's installed

* Python3, Node
* GDAL libraries
* Osmium Tool
* tippecanoe
* mb-util
* tileserver-gl

## Requires

* Ubuntu 18.04
 * Memory 4GB+

## How to use

### Ubuntu 18.04 server

1. Launch a new Ubuntu 18.04 based server.
2. Run following command.

```bash
$ curl https://raw.githubusercontent.com/tilecloud/planet-factory/master/bin/setup.sh | bash
```

### Vagrant

```
$ git clone git@github.com:tilecloud/planet-factory.git && cd planet-factory
$ vagrant up
```

### Docker

Please wait. :)

## Example workflow to develop vector tile

Place a shell script as follows and run it.

```bash
#!/usr/bin/env bash

set -ex

TMPFILE=`mktemp`
TMPDIR=`mktemp -d`

curl -L "https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/physical/110m_physical.zip" -o $TMPFILE
unzip -d $TMPDIR $TMPFILE

find $TMPDIR -name "*.shp" -exec ogr2ogr -f GeoJSON {}.geojson {} \;

tippecanoe --extend-zooms-if-still-dropping --coalesce-densest-as-needed -l water -o water.mbtiles $TMPDIR/ne_110m_ocean.shp.geojson $TMPDIR/ne_110m_lakes.shp.geojson --force
```

Then run `tileserver-gl water.mbtiles` and open `http://<ip-address>:8080/`.

If you are using a vagrant, you can open it on `http://localhost:8080/`.