#!/bin/sh

TMPFILE=`mktemp --suffix=.deb`

wget -O $TMPFILE -c https://www.klayout.org/downloads/Ubuntu-26/klayout_0.30.12-1_amd64.deb
sudo apt update
sudo apt install $TMPFILE

rm $TMPFILE

