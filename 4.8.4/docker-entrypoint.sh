#!/bin/bash

# check if the `config.xml` file has been changed since the creation of this
# Docker image. If the file has been changed the entrypoint script will not
# perform modifications to the configuration file.
if [ "$(stat -c "%Y" "${CRUC_INSTALL}/config.xml")" -eq "0" ]; then
  if [ -n "${X_PROXY_NAME}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//http[@bind=":8060"]' --type "attr" --name "proxy-host" --value "${X_PROXY_NAME}" "${CRUC_INSTALL}/config.xml"
  fi
  if [ -n "${X_PROXY_PORT}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//http[@bind=":8060"]' --type "attr" --name "proxy-port" --value "${X_PROXY_PORT}" "${CRUC_INSTALL}/config.xml"
  fi
  if [ -n "${X_PROXY_SCHEME}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//http[@bind=":8060"]' --type "attr" --name "proxy-scheme" --value "${X_PROXY_SCHEME}" "${CRUC_INSTALL}/config.xml"
  fi
fi

exec "$@"
