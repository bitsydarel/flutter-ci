#!/bin/sh

## maintainer Darel Bitsy <bitsydarel@gmail.com>

if [ "$WITH_GRADLE" = "false" ]; then
  echo "Skipping gradle installation"
else
  wget -O "$TOOLS_HOME"/gradle.zip https\://services.gradle.org/distributions/gradle-"$GRADLE_VERSION"-all.zip && unzip "$TOOLS_HOME"/gradle.zip
  rm -rf "$TOOLS_HOME"/gradle.zip && export PATH="$PATH":"$TOOLS_HOME"/gradle-"$GRADLE_VERSION":"$TOOLS_HOME"/gradle-"$GRADLE_VERSION"/bin
fi
