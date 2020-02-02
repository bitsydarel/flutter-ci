#!/bin/bash

## maintainer Darel Bitsy <bitsydarel@gmail.com>

if [ -z "$1" ]; then flutter_version="stable"; else flutter_version="$1"; fi

ENV_FILE=/etc/profile

touch $ENV_FILE

{
  echo export FLUTTER_HOME="$TOOLS_HOME"/flutter
  echo export FLUTTER_ROOT="$FLUTTER_HOME"
  echo export FLUTTER_CHANNEL="$flutter_version"
  echo export TOOLS_HOME="$HOME"
} >>$ENV_FILE

source "$ENV_FILE"

mkdir -p "$TOOLS_HOME" && cd "$TOOLS_HOME" && git clone -b "$FLUTTER_CHANNEL" https://github.com/flutter/flutter.git

echo export PATH "$PATH":"$FLUTTER_HOME"/bin:"$FLUTTER_HOME"/bin/cache/dart-sdk/bin:"$HOME"/.pub-cache/bin >>$ENV_FILE

source "$ENV_FILE"

flutter doctor -v && pub global activate dbstyleguidechecker && pub global activate junitreport

sudo gem install bundle && alias fastlane='bundle exec fastlane'
