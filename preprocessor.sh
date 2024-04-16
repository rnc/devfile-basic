#!/bin/sh
/root/software/system-java/bin/java -jar /root/software/build-request-processor/quarkus-run.jar gradle-prepare /root/project/workspace -dp com.diffplug.gradle.spotless -dp kotlin.gradle.targets.js -dp org.gradle.api.plugins.quality -dp org.gradle.plugins.signing -dp org.jetbrains.dokka
