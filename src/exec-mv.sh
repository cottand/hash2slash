#!/usr/bin/env bash    

# the temp directory used, within $DIR
WORK_DIR=`mktemp -d`



# check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "hash2slash: could not create temp dir"
  exit 1
fi

# deletes the temp directory
function cleanup {      
  rm -rf "$WORK_DIR"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT


BASENAME=$(basename $1)

# copy file over, removing hashes
cat $1 | sed 's/#!/\/\//g' >> $WORK_DIR/$BASENAME

EXEC $WORK_DIR/$BASENAME $@

exit $?



