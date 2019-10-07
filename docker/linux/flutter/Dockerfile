FROM bitsydarel:android

LABEL maintainer="Darel Bitsy <bitsydarel@gmail.com>"
LABEL description="A docker image for flutter development on linux"

# Flutter channel
ARG flutter_channel=stable

ENV FLUTTER_HOME $TOOLS_HOME/flutter
ENV FLUTTER_ROOT $FLUTTER_HOME
ENV FLUTTER_CHANNEL $flutter_channel

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

## Setup Flutter dependencies and environment
RUN cd $TOOLS_HOME && git clone -b $FLUTTER_CHANNEL https://github.com/flutter/flutter.git

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:$HOME.pub-cache/bin

RUN flutter doctor -v