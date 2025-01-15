#!/bin/sh
file=$1
correct_hash=$2

hash="$( sha256sum $file | awk '{ print $1 }')"
if [ "$hash" == "$correct_hash" ] ; then
    echo "True" >&1
    exit 0
else 
    echo "False" >&2
    exit 1
fi
