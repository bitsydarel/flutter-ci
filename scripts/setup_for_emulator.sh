#!/bin/sh

## maintainer Darel Bitsy <bitsydarel@gmail.com>

if [ "$WITH_EMULATOR" = "false" ];
then
  echo "running without emulator";
  avdmanager list avd
else
  yes | sdkmanager "system-images;android-$ANDROID_PLATFORM_VERSION;$ANDROID_EMULATOR_TYPE;$ANDROID_EMULATOR_ARCH"
  wget -O "$TOOLS_HOME"/wait_for_android_emulator.sh https://raw.githubusercontent.com/bitsydarel/flutter-ci/master/scripts/wait_for_android_emulator.sh && chmod +x "$TOOLS_HOME"/wait_for_android_emulator.sh;
  wget -O "$TOOLS_HOME"/launch_android_emulator.sh https://raw.githubusercontent.com/bitsydarel/flutter-ci/master/scripts/launch_android_emulator.sh && chmod +x "$TOOLS_HOME"/launch_android_emulator.sh
  printf 'no\n' | avdmanager create avd -n android_emulator -k "system-images;android-$ANDROID_PLATFORM_VERSION;$ANDROID_EMULATOR_TYPE;$ANDROID_EMULATOR_ARCH"
fi