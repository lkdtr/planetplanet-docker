#!/bin/sh

PLANETPLANET_DIRECTORY="/planetplanet"
PLANETPLANET_CONFIG="/planetplanet/gezegen/config.ini"

cd $PLANETPLANET_DIRECTORY

ls

exec python2.7 $PLANETPLANET_DIRECTORY/planet.py $PLANETPLANET_CONFIG
