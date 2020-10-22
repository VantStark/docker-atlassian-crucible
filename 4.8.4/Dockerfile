FROM openjdk:8-alpine

# Setup useful environment variables
ENV CRUC_HOME     /var/atlassian/crucible
ENV CRUC_INSTALL  /opt/atlassian/crucible
ENV CRUC_VERSION  4.8.4

ENV JAVA_CACERTS  $JAVA_HOME/jre/lib/security/cacerts

# Install Atlassian Crucible and helper tools and setup initial home
# directory structure.
RUN set -x \
    && apk add --no-cache curl xmlstarlet bash ttf-dejavu libc6-compat gcompat unzip

RUN mkdir -p                   "${CRUC_HOME}" \
    && chmod -R 700            "${CRUC_HOME}" \
    && chown daemon:daemon     "${CRUC_HOME}" \
    && mkdir -p                "${CRUC_INSTALL}" \
    && curl -Ls                "https://xicc.cc:9900/mirror/atlassian-crucible/v${CRUC_VERSION}/crucible-${CRUC_VERSION}.zip" -o /tmp/crucible-${CRUC_VERSION}.zip \
    && unzip                   /tmp/crucible-${CRUC_VERSION}.zip -d/tmp \
    && mv                      /tmp/fecru-${CRUC_VERSION}/* ${CRUC_INSTALL}/ \
    && rm -rf                  /tmp/fecru-${CRUC_VERSION} /tmp/crucible-${CRUC_VERSION}.zip \
    && curl -Ls                "https://xicc.cc:9900/mirror/mysql-connector-java/v5.1.44/mysql-connector-java-5.1.44.tar.gz" | tar -xz --directory "${CRUC_INSTALL}/lib" --strip-components=1 --no-same-owner "mysql-connector-java-5.1.44/mysql-connector-java-5.1.44-bin.jar" \
    && curl -Ls                "https://xicc.cc:9900/mirror/atlassian-agent/v1.2.3/atlassian-agent.jar" -o "${CRUC_INSTALL}/atlassian-agent.jar" \
    && sed --in-place          "s/# make it fully qualified/export FISHEYE_INST=\"\/var\/atlassian\/crucible\"/g" "${CRUC_INSTALL}/bin/fisheyectl.sh" \
    && sed --in-place          "s/\/endorsed\"/\/endorsed -javaagent:\/opt\/atlassian\/crucible\/atlassian-agent.jar\"/g" "${CRUC_INSTALL}/bin/fisheyectl.sh" \
    && touch -d "@0"           "${CRUC_INSTALL}/config.xml" \
    && chown daemon:daemon     "${JAVA_CACERTS}"

# Use the default unprivileged account. This could be considered bad practice
# on systems where multiple processes end up being executed by 'daemon' but
# here we only ever run one process anyway.
USER root:root

# Expose default HTTP connector port.
EXPOSE 8060

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
VOLUME ["${CRUC_HOME}", "${CRUC_INSTALL}"]

# Set the default working directory as the installation directory.
WORKDIR ${CRUC_HOME}

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# Run Atlassian Crucible as a foreground process by default.
CMD ["/opt/atlassian/crucible/bin/run.sh", "-fg"]