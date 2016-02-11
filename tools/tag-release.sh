#!/bin/bash
#
# Script used to tag the release
#

set -e

MY_PATH=$(cd ${0%/*} && echo $PWD/${0##*/})
TOOL_PATH=`dirname "$MY_PATH"`
VERSION=`$TOOL_PATH/get-version.js`

git fetch --tags
if [ "`git tag -l | grep $VERSION`" != "" ] ; then
  echo "Warning: version $VERSION already exists. Aborting ..."
  exit 2
fi

git tag -d latest
git push origin :latest
git tag -a -m "Version $VERSION" latest
git tag -a -m "Version $VERSION" $VERSION
git push --tags

exit 0