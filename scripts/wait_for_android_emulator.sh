#!/bin/bash

## maintainer Darel Bitsy <bitsydarel@gmail.com>

emulator_booted=""
failcounter=0
timeout_in_sec=900

until [[ "$emulator_booted" =~ "1" ]]; do
  emulator_booted=$(adb -e shell getprop sys.boot_completed 2>&1 &)
  if [[ "$emulator_booted" =~ "device not found" || "$emulator_booted" =~ "device offline" || "$emulator_booted" =~ "running" ]]; then
    ((failcounter += 1))
    echo "Waiting for emulator to start"
    if [[ $failcounter -gt timeout_in_sec ]]; then
      echo "Timeout ($timeout_in_sec seconds) reached; failed to start emulator"
      exit 1
    fi
  fi
  sleep 1
done

echo "Emulator is ready"