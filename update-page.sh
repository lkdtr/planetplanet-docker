#!/bin/sh

PLANETPLANET_DIRECTORY="/planetplanet"

cd $PLANETPLANET_DIRECTORY

exec python2.7 $PLANETPLANET_DIRECTORY/planet.py $PLANETPLANET_DIRECTORY/gezegen/config.ini
#exec python2.7 $PLANETPLANET_DIRECTORY/planet.py $PLANETPLANET_DIRECTORY/gezegen-lkd/config.ini
#exec python2.7 $PLANETPLANET_DIRECTORY/planet.py $PLANETPLANET_DIRECTORY/gezegen-topluluk/config.ini
#exec python2.7 $PLANETPLANET_DIRECTORY/planet.py $PLANETPLANET_DIRECTORY/gezegen/config.ini
#exec python2.7 $PLANETPLANET_DIRECTORY/planet.py $PLANETPLANET_DIRECTORY/gezegen/config.ini
