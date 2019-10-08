#!/bin/sh
cd "$TOOLS_HOME" && emulator -avd android_emulator -no-window -noaudio -no-boot-anim -gpu swiftshader_indirect -accel "$ANDROID_EMULATOR_ACCEL" -verbose -debug all &
./android-wait-for-emulator
