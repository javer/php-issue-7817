#!/bin/sh

URL=http://127.0.0.1:8080/api/doc.json

while true; do
  rm -rf var/cache/dev
  for i in `seq 1 2`; do
    curl $URL >/dev/null || exit
  done
done
