FROM ubuntu:bionic

LABEL maintainer="bitsydarel@gmail.com"
LABEL description="A docker image for flutter development on linux"

# setup global environment
ENV TOOLS_HOME /root/tools

ARG with_emulator=true

ENV WITH_EMULATOR=$with_emulator

ARG android_sdk_version=4333796
ARG android_platform_version=28
ARG android_build_tools_version=29.0.2

# setup environment variables for android sdk
ENV ANDROID_SDK_HOME $TOOLS_HOME/android-sdk-linux
ENV ANDROID_SDK_ROOT $ANDROID_SDK_HOME
ENV ANDROID_HOME $ANDROID_SDK_HOME
ENV ANDROID_SDK $ANDROID_SDK_HOME
ENV ANDROID_SDK_TOOLS_VERSION $android_sdk_version

ENV ANDROID_PLATFORM_VERSION $android_platform_version
ENV ANDROID_BUILD_TOOLS_VERSION $android_build_tools_version

# Flutter channel
ARG flutter_channel=stable

ENV FLUTTER_HOME $TOOLS_HOME/flutter
ENV FLUTTER_ROOT $FLUTTER_HOME
ENV FLUTTER_CHANNEL $flutter_channel

USER root

# Setup android dependencies and envirements
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --no-install-recommends apt-utils apt-transport-https apt-config-auto-update locales multiarch-support && apt-get autoclean

RUN apt-get install -y --no-install-recommends software-properties-common curl netbase wget git gdb unzip ruby ruby-dev tar unzip && apt-get autoclean

RUN add-apt-repository ppa:openjdk-r/ppa && apt-get update && apt-get install -y --no-install-recommends openjdk-8-jdk openjdk-8-jre && add-apt-repository --remove ppa:openjdk-r/ppa

RUN apt-get install -y --no-install-recommends xvfb lib32z1 lib32stdc++6 libstdc++6 build-essential libcurl4-openssl-dev libglu1-mesa libxi-dev libxmu-dev libglu1-mesa-dev lcov

RUN apt-get autoclean && rm -rf /var/lib/apt/lists/* && ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime && locale-gen en_US.UTF-8 || true

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir $TOOLS_HOME && cd $TOOLS_HOME

RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-$ANDROID_SDK_TOOLS_VERSION.zip -O android-sdk-tools.zip && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} && rm android-sdk-tools.zip

ENV PATH ${PATH}:${ANDROID_SDK_HOME}/tools:${ANDROID_SDK_HOME}/tools/bin:${ANDROID_SDK_HOME}/platform-tools

RUN mkdir /root/.android && touch /root/.android/repositories.cfg && yes | sdkmanager --update && yes | sdkmanager --licenses

RUN sdkmanager tools platform-tools emulator "patcher;v4"

RUN yes | sdkmanager "platforms;android-$ANDROID_PLATFORM_VERSION" "build-tools;$ANDROID_BUILD_TOOLS_VERSION" "extras;google;m2repository" "extras;android;m2repository"

## Setup Flutter dependencies and environment
RUN cd $TOOLS_HOME && git clone -b $FLUTTER_CHANNEL https://github.com/flutter/flutter.git

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:/root/.pub-cache/bin

RUN flutter doctor -v

RUN wget -O /tmp/setup_for_emulator.sh https://raw.githubusercontent.com/bitsydarel/flutter-ci/master/scripts/setup_for_emulator.sh && chmod +x /tmp/setup_for_emulator.sh && sh /tmp/setup_for_emulator.sh;

RUN mkdir /root/projects && cd /root/projects

WORKDIR /root/projects