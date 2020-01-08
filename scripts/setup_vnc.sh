#!/bin/bash

## maintainer Darel Bitsy <bitsydarel@gmail.com>

set +e

mkdir -p "${HOME}"/.vnc

x11vnc -storepasswd "${VNC_PASSWORD}" "${HOME}"/.vnc/passwd

ls -a "${HOME}" && ls -a "${HOME}"/.vnc