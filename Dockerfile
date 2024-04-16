
# Builder images
FROM quay.io/ncross/hacbs-jvm-build-request-processor:dev AS build-request-processor

# Base Image (which in itself derives from a JBS builder image)
FROM quay.io/ncross/artifact-deployments:975ea3800099190263d38f051c1a188a-pre-build-image

# Actually pre-build-image derives from builder image so we don't need the below.
# This provides the /opt[tools] and /usr/lib/jvm[java]
# FROM quay.io/redhat-user-workloads/rhtap-build-tenant/jvm-build-service-builder-images/ubi8:d6c417eae5fe32f3207918c6395881843e534a5d

USER 0
WORKDIR /root

RUN mkdir -p /root/project /root/software/settings /original-content/marker && microdnf install vim curl procps-ng bash-completion
# DEBUG ONLY
RUN rpm -ivh https://rpmfind.net/linux/centos/8-stream/BaseOS/x86_64/os/Packages/tree-1.7.0-15.el8.x86_64.rpm

COPY --from=build-request-processor /deployments/ /root/software/build-request-processor
# Only needed to setup JDK17 for build-request-processor. Note UBI8 based images already include java17.
COPY --from=build-request-processor /lib/jvm/jre-17 /root/software/system-java
COPY --from=build-request-processor /etc/java/java-17-openjdk /etc/java/java-17-openjdk

#Not required as we derive from the pre-build-image now.
#COPY --from=pre-build-image /original-content/workspace /root/project/workspace
RUN cp -ar /original-content/workspace /root/project/workspace

# Hack - use existing scripts for now.
COPY preprocessor.sh /root
COPY build.sh /root
COPY run-full-build.sh /root

ENV DISABLE_JBS_REPOSITORY_PLUGIN=true

# This will build the project and deploy artifacts to /root/project/artifacts
RUN /root/run-full-build.sh

# Do we need another layer like:
# FROM scratch
# COPY <artifacts>
