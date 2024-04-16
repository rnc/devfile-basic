#!/bin/sh
/root/preprocessor.sh
cd /root/project/workspace
export MAVEN_HOME=/opt/maven/3.8.8
export GRADLE_HOME=/opt/gradle/4.10.3
export TOOL_VERSION=4.10.3
export PROJECT_VERSION=1.7.0
export JAVA_HOME=/lib/jvm/java-1.8.0
export ENFORCE_VERSION=

/root/build.sh assemble publishToMavenLocal -DdisableTests
