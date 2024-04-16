#!/bin/sh

# Gradle
/root/software/system-java/bin/java -jar /root/software/build-request-processor/quarkus-run.jar gradle-prepare /root/project/workspace -dp com.diffplug.gradle.spotless -dp kotlin.gradle.targets.js -dp org.gradle.api.plugins.quality -dp org.gradle.plugins.signing -dp org.jetbrains.dokka

# Maven
# /root/software/system-java/bin/java -jar /root/software/build-request-processor/quarkus-run.jar maven-prepare /root/project/workspace -dp org.glassfish.copyright:glassfish-copyright-maven-plugin -dp org.sonatype.plugins:nexus-staging-maven-plugin -dp com.mycila:license-maven-plugin -dp org.codehaus.mojo:findbugs-maven-plugin -dp de.jjohannes:gradle-module-metadata-maven-plugin -dp org.codehaus.mojo:cobertura-maven-plugin -dp com.diffplug.spotless:spotless-maven-plugin -dp io.fabric8:docker-maven-plugin -dp org.apache.rat:apache-rat-plugin
