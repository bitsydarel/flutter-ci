# flutter-ci

## Android CI

# Supported tags and respective `Dockerfile` links

-	[`latest`](https://github.com/bitsydarel/flutter-ci/blob/master/docker/linux/android/Dockerfile) Docker image contains android sdk latest stable version, android platform api 28, android emulator x86_64 and other automation tools.

- [`api-25-armeabi-v7a`](https://github.com/bitsydarel/flutter-ci/blob/master/docker/linux/android/Dockerfile) Docker image contains android sdk latest stable version, android platform api 25, Android emulator armeabi-v7a and other automation tools.

- [`no-emulator`](https://github.com/bitsydarel/flutter-ci/blob/master/docker/linux/android/Dockerfile) Docker image contains android sdk latest stable version, android platform api 28 and other automation tools.

- [`gradle-5.4.1`](https://github.com/bitsydarel/flutter-ci/blob/master/docker/linux/android/Dockerfile) Docker image contains gradle 5.4.1, android sdk latest stable version, android emulator x86_64 and other automation tools.


## Flutter CI

# Supported tags and respective `Dockerfile` links

-	[`latest`](https://github.com/bitsydarel/flutter-ci/blob/master/docker/linux/flutter/Dockerfile) Docker image contains flutter latest stable version, Android emulator x86_64 and other automation tools.

- [`arm`](https://github.com/bitsydarel/flutter-ci/blob/master/docker/linux/flutter/Dockerfile) Docker image contains flutter latest stable version, Android emulator arm and other automation tools.

- [`latest-no-emulator`](https://github.com/bitsydarel/flutter-ci/blob/master/docker/linux/flutter/Dockerfile) Docker image contains flutter latest stable version and other automation tools.

# Tools
-	**Android Sdk**:
  Provide tools to develop on android, Tools to create and manage emulators, ADB (Android Debug Bridge) to communicate with emulator or devices connected to the docker container.

-	**VNC**:
  Using x11vnc and xvfb, default VNC Password: 1234

-	**dbstyleguidechecker**:
  Check a project agains a flutter or dart code style, using the analysis_options.yaml, support commenting on github pull requests.

-	**fastlane**:
  Allow to run tools like fastlane if available in the project (Gemfile).

-	**junitreport**:
  create a junit report from a flutter test report.

-	**lcov and genhtml**:
  generate code coverage report and html code coverage report.

-	**lftp**:
  Send build artifact to ftp server and more.

-	**qrencode**:
  Generate QR code.

# Quick reference

-	**Where to get help**:  
  [Project issues](https://github.com/bitsydarel/flutter-ci/issues), [Flutter issues](https://github.com/flutter/flutter/issues), [Flutter Stack Overflow](https://stackoverflow.com/search?tab=newest&q=flutter), [the Docker Community Forums](https://forums.docker.com/), [the Docker Community Slack](http://dockr.ly/slack), or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker)

-	**Where to file issues**:  
  [https://github.com/bitsydarel/flutter-ci/issues](https://github.com/bitsydarel/flutter-ci/issues)

-	**Maintained by**:  
  [Bitsy Darel](https://www.linkedin.com/in/darel-bitsy/)

-	**Image change logs**:  
  [Change logs](https://github.com/bitsydarel/flutter-ci/releases)
