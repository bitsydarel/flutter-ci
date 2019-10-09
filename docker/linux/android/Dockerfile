FROM ubuntu:bionic

LABEL maintainer="Darel Bitsy <bitsydarel@gmail.com>"
LABEL description="A docker image for android development on linux"

ENV HOME /home/sandbox

ARG DEBIAN_FRONTEND=noninteractive

ARG with_emulator=true
ARG vnc_password=1234

ENV WITH_EMULATOR=$with_emulator
ENV VNC_PASSWORD=$vnc_password

ARG android_sdk_version=4333796
ARG android_platform_version=28
ARG android_build_tools_version=29.0.2
ARG android_emulator_arch=x86_64
ARG android_emulator_type=google_apis_playstore
ARG android_emulator_accel=off

# setup global environment
ENV TOOLS_HOME $HOME/tools

# setup environment variables for android sdk
ENV ANDROID_SDK_HOME $TOOLS_HOME/android-sdk
ENV ANDROID_SDK_ROOT $ANDROID_SDK_HOME
ENV ANDROID_HOME $ANDROID_SDK_HOME
ENV ANDROID_SDK $ANDROID_SDK_HOME
ENV ANDROID_SDK_TOOLS_VERSION $android_sdk_version

ENV ANDROID_PLATFORM_VERSION $android_platform_version
ENV ANDROID_BUILD_TOOLS_VERSION $android_build_tools_version
ENV ANDROID_EMULATOR_ARCH $android_emulator_arch
ENV ANDROID_EMULATOR_TYPE $android_emulator_type
ENV ANDROID_EMULATOR_ACCEL=$android_emulator_accel
ENV QT_DEBUG_PLUGINS=1
# Setup android dependencies and envirements
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends apt-utils apt-transport-https apt-config-auto-update locales multiarch-support \
    && apt-get autoclean

RUN apt-get install -y --no-install-recommends --allow-unauthenticated software-properties-common curl netbase wget git gdb unzip ruby ruby-dev tar unzip x11vnc xvfb mesa-utils xorg openbox qt5-default && apt-get autoclean

RUN add-apt-repository ppa:openjdk-r/ppa \
    && apt-get update && apt-get install -y --no-install-recommends openjdk-8-jdk openjdk-8-jre \
    && add-apt-repository --remove ppa:openjdk-r/ppa \
    && apt-get install -y --no-install-recommends qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils xvfb lib32z1 lib32stdc++6 libstdc++6 build-essential libcurl4-openssl-dev libglu1-mesa libxi-dev libxmu-dev libglu1-mesa-dev lcov

RUN apt-get autoclean && rm -rf /var/lib/apt/lists/* && ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime && locale-gen en_US.UTF-8 || true

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en
ENV DISPLAY=:1

RUN mkdir -p $TOOLS_HOME && cd $TOOLS_HOME

ENV PATH ${PATH}:${TOOLS_HOME}

RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-$ANDROID_SDK_TOOLS_VERSION.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm android-sdk-tools.zip

ENV PATH ${PATH}:${ANDROID_SDK_HOME}/emulator:${ANDROID_SDK_HOME}/tools/bin:${ANDROID_SDK_HOME}/platform-tools

RUN sdkmanager --update && yes | sdkmanager --licenses

RUN sdkmanager tools platform-tools emulator "patcher;v4"

RUN yes | sdkmanager "platforms;android-$ANDROID_PLATFORM_VERSION" "build-tools;$ANDROID_BUILD_TOOLS_VERSION" "extras;google;m2repository" "extras;android;m2repository"

RUN wget -O /tmp/setup_for_emulator.sh https://raw.githubusercontent.com/bitsydarel/flutter-ci/master/scripts/setup_for_emulator.sh \
    && chmod +x /tmp/setup_for_emulator.sh \
    && sh /tmp/setup_for_emulator.sh \
    && rm -rf /tmp/setup_for_emulator.sh;

RUN mkdir -p $HOME/projects && cd $HOME/projects && mkdir -p $HOME/.vnc \
    && x11vnc -storepasswd $VNC_PASSWORD $HOME/.vnc/passwd && x11vnc -forever -usepw -create &

RUN touch /etc/ld.so.conf.d/android_libs.conf \
    && echo "$ANDROID_SDK_HOME/emulator/lib64/qt/lib" >> /etc/ld.so.conf.d/android_libs.conf \
    && echo "$ANDROID_SDK_HOME/emulator/lib64" >> /etc/ld.so.conf.d/android_libs.conf

WORKDIR $HOME/projects

RUN groupadd -g 1000 sandbox && useradd -u 1000 -g 1000 -G root -s /bin/bash -o -m -d $HOME sandbox \
        && usermod -aG root sandbox \
        && chown --recursive 1000:1000 ${HOME} \
        && chmod -R 777 $HOME \
        && chmod -R 777 $TOOLS_HOME \
        && chmod -R 777 .

USER [sandbox]