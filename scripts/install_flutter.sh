#!/bin/bash

## maintainer Darel Bitsy <bitsydarel@gmail.com>

if [ -z "$1" ]; then flutter_version="stable"; else flutter_version="$1"; fi

{
  echo export FLUTTER_HOME="$TOOLS_HOME"/flutter
  echo export FLUTTER_ROOT="$FLUTTER_HOME"
  echo export FLUTTER_CHANNEL="$flutter_version"
  echo export TOOLS_HOME="$HOME"
} >>/etc/profile.d/vm_env.sh

chmod +x /etc/profile.d/vm_env.sh

bash /etc/profile.d/vm_env.sh

mkdir -p "$TOOLS_HOME" && cd "$TOOLS_HOME" && git clone -b "$FLUTTER_CHANNEL" https://github.com/flutter/flutter.git

echo export PATH "$PATH":"$FLUTTER_HOME"/bin:"$FLUTTER_HOME"/bin/cache/dart-sdk/bin:"$HOME"/.pub-cache/bin >>/etc/profile.d/vm_env.sh

bash /etc/profile.d/vm_env.sh

flutter doctor -v && pub global activate dbstyleguidechecker && pub global activate junitreport

sudo gem install bundle && alias fastlane='bundle exec fastlane'