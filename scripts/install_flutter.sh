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

if [ -z "$FASTLANE_USER" ] && [ -z "$FASTLANE_PASSWORD" ] && [ -z "$XCODE_VERSION" ]; then
  echo "Xcode installation skipped."
  echo "Because FASTLANE_USER, FASTLANE_PASSWORD, XCODE_VERSION environment variables are missing."
else
  echo "Updating ruby version so we could install xcode-install tool"
  source "$USER_ENV_FILE"
  brew update
  brew install ruby

  echo "Updating PATH to find new ruby binary"
  echo export PATH="/usr/local/opt/ruby/bin:\$PATH" | tee -a "$USER_ENV_FILE" >/dev/null

  for directory in $(find /usr/local/lib/ruby/gems -maxdepth 2 -type d -name bin); do
    echo export PATH="$directory:\$PATH" | tee -a "$USER_ENV_FILE" >/dev/null
  done

  source "$USER_ENV_FILE"
  export XCODE_INSTALL_USER=$FASTLANE_USER
  export XCODE_INSTALL_PASSWORD=$FASTLANE_PASSWORD

  echo "Installing Xcode version: $XCODE_VERSION"
  sudo gem install xcode-install
  xcversion install "$XCODE_VERSION"
fi

source "$SYSTEM_ENV_FILE"

flutter doctor -v && pub global activate dbstyleguidechecker && pub global activate junitreport
