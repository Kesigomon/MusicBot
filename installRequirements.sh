#!/bin/bash
if [ ! -d "./wheels" ]; then
  pip3 install -r requirements.txt
else
  mv wheels/wheels /tmp/wheels
  rm -r wheels
  pip3 install -r requirements.txt --no-index --find-links=/tmp/wheels
fi