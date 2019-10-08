#!/bin/bash

## maintainer Darel Bitsy <bitsydarel@gmail.com>

set +e

emulator_booted=""
failcounter=0
retry_counter=15

until [[ "$emulator_booted" =~ "1" ]]; do
  emulator_booted=$(adb -e shell getprop sys.boot_completed 2>&1 &)
  if [[ "$emulator_booted" =~ "device not found" || "$emulator_booted" =~ "device offline" || "$emulator_booted" =~ "running" ]]; then
    ((failcounter += 1))
    echo "Waiting for emulator to start"
    if [[ $failcounter -gt retry_counter ]]; then
      echo "Retry count $retry_counter reached; failed to start emulator"
      exit 1
    fi
  fi
  sleep 60
done

echo "Emulator is ready"