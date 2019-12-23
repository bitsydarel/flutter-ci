#!/bin/sh

## maintainer Darel Bitsy <bitsydarel@gmail.com>

if [ "$WITH_GRADLE" = "false" ]; then
  echo "Skipping gradle installation"
else
  wget -O "$TOOLS_HOME"/gradle.zip https\://services.gradle.org/distributions/gradle-"$GRADLE_VERSION"-all.zip && unzip "$TOOLS_HOME"/gradle.zip -d "$TOOLS_HOME"
  rm -rf "$TOOLS_HOME"/gradle.zip
fi
