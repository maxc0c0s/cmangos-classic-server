FROM maxc0c0s/cmangos-classic-base

ENV STARTUP_SCRIPTS_DIR=/startup-scripts.d
RUN mkdir -p $STARTUP_SCRIPTS_DIR

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
