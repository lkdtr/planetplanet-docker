#!/bin/sh

PLANETPLANET_DIRECTORY="/planetplanet"
PLANETPLANET_CONFIG="/planetplanet/gezegen/config.ini"

cd $PLANETPLANET_DIRECTORY

exec ls

exec python2.7 $PLANETPLANET_DIRECTORY/gezegen/planet.py $PLANETPLANET_CONFIG
