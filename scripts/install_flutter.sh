#!/bin/bash

## maintainer Darel Bitsy <bitsydarel@gmail.com>

if [ -z "$1" ]; then flutter_version="stable"; else flutter_version="$1"; fi
if [ -z "$VAGRANT_HOME" ]; then homeDir="$HOME"; else homeDir="$VAGRANT_HOME"; fi

ENV_FILE=/etc/profile

echo export TOOLS_HOME="$homeDir/tools" | sudo tee -a $ENV_FILE >/dev/null
echo export FLUTTER_HOME="$homeDir/tools/flutter" | sudo tee -a $ENV_FILE >/dev/null
echo export FLUTTER_ROOT="$homeDir/tools/flutter" | sudo tee -a $ENV_FILE >/dev/null
echo export FLUTTER_CHANNEL="$flutter_version" | sudo tee -a $ENV_FILE >/dev/null

source "$ENV_FILE"

mkdir -p "$TOOLS_HOME" && cd "$TOOLS_HOME" && git clone -b "$FLUTTER_CHANNEL" https://github.com/flutter/flutter.git

echo export PATH="$PATH":"$FLUTTER_HOME"/bin:"$FLUTTER_HOME"/bin/cache/dart-sdk/bin:"$homeDir"/.pub-cache/bin | sudo tee -a $ENV_FILE >/dev/null

source "$ENV_FILE"

#brew install ruby

echo export PATH="/usr/local/opt/ruby/bin:$PATH" | tee -a  >> "$homeDir/.bash_profile"
echo export LC_ALL=en_US.UTF-8 | tee -a  >> "$homeDir/.bash_profile"
echo export LANG=en_US.UTF-8 | tee -a  >> "$homeDir/.bash_profile"

sudo gem install bundle && alias fastlane='bundle exec fastlane'
#sudo gem install xcode-install
sudo gem install cocoapods

flutter doctor -v && pub global activate dbstyleguidechecker && pub global activate junitreport