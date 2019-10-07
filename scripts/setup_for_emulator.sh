#!/bin/sh

## maintainer Darel Bitsy <bitsydarel@gmail.com>

if [ "$WITH_EMULATOR" = "false" ];
then
  echo "running without emulator";
  avdmanager list avd
else
  yes | sdkmanager "system-images;android-$ANDROID_PLATFORM_VERSION;google_apis_playstore;$ANDROID_EMULATOR_ARCH"
  wget -O "$TOOLS_HOME"/android-wait-for-emulator https://raw.githubusercontent.com/travis-ci/travis-cookbooks/master/community-cookbooks/android-sdk/files/default/android-wait-for-emulator && chmod +x "$TOOLS_HOME"/android-wait-for-emulator;
  wget -O "$TOOLS_HOME"/launch_android_emulator.sh https://raw.githubusercontent.com/bitsydarel/flutter-ci/master/scripts/launch_android_emulator.sh && chmod +x "$TOOLS_HOME"/launch_android_emulator.sh
  printf 'no\n' | avdmanager create avd -n android_emulator -k "system-images;android-$ANDROID_PLATFORM_VERSION;google_apis_playstore;$ANDROID_EMULATOR_ARCH"
fi