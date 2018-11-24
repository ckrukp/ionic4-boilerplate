#!/bin/bash -v

set -e

# Build Ionic App for Android
ls -l
ionic cordova platform add android --nofetch --no-resources

if [[ "$TRAVIS_BRANCH" == "develop" ]]
then
    ionic cordova build android --no-resources
else
    ionic cordova build android --prod --release --no-resources
fi