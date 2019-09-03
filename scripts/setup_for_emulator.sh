#!/bin/sh

if [ "$WITH_EMULATOR" = "false" ];
then
  echo "running without emulator";
  flutter emulators
else
  wget -O /usr/bin/android-wait-for-emulator https://raw.githubusercontent.com/travis-ci/travis-cookbooks/master/community-cookbooks/android-sdk/files/default/android-wait-for-emulator && chmod +x /usr/bin/android-wait-for-emulator;
  flutter emulators --create --name android_emulator -v;
fi