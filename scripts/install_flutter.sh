#!/bin/bash

## maintainer Darel Bitsy <bitsydarel@gmail.com>

if [ -z "$1" ]; then flutter_version="stable"; else flutter_version="$1"; fi
if [ -z "$VAGRANT_HOME" ]; then homeDir="$HOME"; else homeDir="$VAGRANT_HOME"; fi

USER_ENV_FILE="$homeDir/.bash_profile"
SYSTEM_ENV_FILE=/etc/profile

echo export TOOLS_HOME="$homeDir/tools" | sudo tee -a $SYSTEM_ENV_FILE >/dev/null
echo export FLUTTER_HOME="$homeDir/tools/flutter" | sudo tee -a $SYSTEM_ENV_FILE >/dev/null
echo export FLUTTER_ROOT="$homeDir/tools/flutter" | sudo tee -a $SYSTEM_ENV_FILE >/dev/null
echo export FLUTTER_CHANNEL="$flutter_version" | sudo tee -a $SYSTEM_ENV_FILE >/dev/null

source "$SYSTEM_ENV_FILE"

mkdir -p "$TOOLS_HOME" && cd "$TOOLS_HOME" && git clone -b "$FLUTTER_CHANNEL" https://github.com/flutter/flutter.git

echo export PATH="$PATH":"$FLUTTER_HOME"/bin:"$FLUTTER_HOME"/bin/cache/dart-sdk/bin:"$homeDir"/.pub-cache/bin | sudo tee -a $SYSTEM_ENV_FILE >/dev/null

source "$SYSTEM_ENV_FILE"

echo export LC_ALL=en_US.UTF-8 | tee -a "$USER_ENV_FILE" >/dev/null
echo export LANG=en_US.UTF-8 | tee -a "$USER_ENV_FILE" >/dev/null

sudo gem install bundle && alias fastlane='bundle exec fastlane'
sudo gem install cocoapods

if [ -z "$XCODE_INSTALL_USER" ] && [ -z "$XCODE_INSTALL_PASSWORD" ] && [ -z "$XCODE_VERSION" ]; then
  echo "Xcode installation Will not install xcode."
  echo "Because XCODE_INSTALL_USER, XCODE_INSTALL_PASSWORD, XCODE_VERSION environment variables are missing."
else
  source "$USER_ENV_FILE"
  brew update
  brew install ruby
  sudo gem install xcode-install
  echo export PATH="/usr/local/opt/ruby/bin:$PATH" | tee -a "$USER_ENV_FILE" >/dev/null
  echo export PATH="/usr/local/lib/ruby/gems:$PATH" | tee -a "$USER_ENV_FILE" >/dev/null
  source "$USER_ENV_FILE"
  xcversion install "$XCODE_VERSION"
fi

source "$SYSTEM_ENV_FILE"

flutter doctor -v && pub global activate dbstyleguidechecker && pub global activate junitreport
