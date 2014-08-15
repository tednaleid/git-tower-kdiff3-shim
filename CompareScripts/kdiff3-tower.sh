#! /usr/bin/env bash

# Shell script shim to let Tower.app (http://git-tower.com) to integrate with
# the free, open-source, kdiff3 application.
#
# We pipe stderr to /dev/null as kdiff3 is really noisy even when there's no
# problem and it screws up tower thinking there was a problem with the merge

# Tower.app gives us these parameters:
LOCAL="$1"
REMOTE="$2"

# Sanitize LOCAL path
if [[ ! "$LOCAL" =~ ^/ ]]; then
	LOCAL=$(echo "$LOCAL" | sed -e 's/^\.\///')
	LOCAL="$PWD/$LOCAL"
fi

# Sanitize REMOTE path
if [[ ! "$REMOTE" =~ ^/ ]]; then
	REMOTE=$(echo "$REMOTE" | sed -e 's/^\.\///')
	REMOTE="$PWD/$REMOTE"
fi

MERGING="$4"
BACKUP="/tmp/$(date +"%Y%d%m%H%M%S")"

APPLICATION_PATH=/Applications/kdiff3.app
CMD="$APPLICATION_PATH/Contents/MacOS/kdiff3"

if [ ! -x "$CMD" ]; then
	echo "kdiff3 application could not be found!" >&2
	exit 128
fi

if [ -n "$MERGING" ]; then
  BASE="$3"
	MERGE="$4"

	# Sanitize BASE path
	if [[ ! "$BASE" =~ ^/ ]]; then
		BASE=$(echo "$BASE" | sed -e 's/^\.\///')
		BASE="$PWD/$BASE"

		if [ ! -f "$BASE" ]; then
			BASE=/dev/null
		fi
	fi

	# Sanitize MERGE path
	if [[ ! "$MERGE" =~ ^/ ]]; then
		MERGE=$(echo "$MERGE" | sed -e 's/^\.\///')
		MERGE="$PWD/$MERGE"

		if [ ! -f "$MERGE" ]; then
			# For conflict "Both Added", Git does not pass the merge param correctly in current versions
			MERGE=$(echo "$LOCAL" | sed -e 's/\.LOCAL\.[0-9]*//')
		fi
	fi

	sleep 1 # required to create different modification timestamp
	touch "$BACKUP"

  "$CMD" "$LOCAL" "$REMOTE" --base "$BASE" --output "$MERGE_RESULT" 2>/dev/null
else
  "$CMD" "$LOCAL" "$REMOTE" 2>/dev/null
fi

if [ -n "$MERGING" ]; then
	# Check if the merged file has changed
	if [ "$MERGE" -ot "$BACKUP" ]; then
		exit 1
	fi
fi

exit 0
