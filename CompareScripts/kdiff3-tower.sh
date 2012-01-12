#! /usr/bin/env bash

# Shell script shim to let Tower.app (http://git-tower.com) to integrate with
# the free, open-source, kdiff3 application.
#
# We pipe stderr to /dev/null as kdiff3 is really noisy even when there's no 
# problem and it screws up tower thinking there was a problem with the merge

# Tower.app gives us these parameters:
LOCAL="$1"
REMOTE="$2"
BASE="$3"
MERGE_RESULT="$4"

APPLICATION_PATH=/Applications/kdiff3.app
CMD="$APPLICATION_PATH/Contents/MacOS/kdiff3"

if [ -z $BASE ]; then
    "$CMD" "$1" "$2" 2>/dev/null
else
    "$CMD" "$3" "$1" "$2" --output "$4" 2>/dev/null
fi

