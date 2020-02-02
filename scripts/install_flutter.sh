#!/bin/bash

## maintainer Darel Bitsy <bitsydarel@gmail.com>

if [ -z "$1" ]; then flutter_version="stable"; else flutter_version="$1"; fi

ENV_FILE=/etc/profile

sudo touch $ENV_FILE

sudo echo export TOOLS_HOME="$HOME/tools" | sudo tee -a $ENV_FILE >/dev/null
sudo echo export FLUTTER_HOME="$TOOLS_HOME"/flutter | sudo tee -a $ENV_FILE >/dev/null
sudo echo export FLUTTER_ROOT="$FLUTTER_HOME" | sudo tee -a $ENV_FILE >/dev/null
sudo echo export FLUTTER_CHANNEL="$flutter_version" | sudo tee -a $ENV_FILE >/dev/null

source "$ENV_FILE"

mkdir -p "$TOOLS_HOME" && cd "$TOOLS_HOME" && git clone -b "$FLUTTER_CHANNEL" https://github.com/flutter/flutter.git

echo export PATH "$PATH":"$FLUTTER_HOME"/bin:"$FLUTTER_HOME"/bin/cache/dart-sdk/bin:"$HOME"/.pub-cache/bin | sudo tee -a $ENV_FILE >/dev/null

source "$ENV_FILE"

flutter doctor -v && pub global activate dbstyleguidechecker && pub global activate junitreport

sudo gem install bundle && alias fastlane='bundle exec fastlane'
