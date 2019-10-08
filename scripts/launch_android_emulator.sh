#!/bin/sh
adb start-server
{ emulator -avd android_emulator -no-window -noaudio -no-boot-anim -gpu swiftshader_indirect -accel "$ANDROID_EMULATOR_ACCEL" -show-kernel -verbose -debug all > emulator.log; } 2>&1 &
android-wait-for-emulator
