#!/usr/bin/env sh
# Usage:
# ./entrypoint.sh /etc/searx/settings.yml

# TODO: Rewrite this to use arguments, so it can be modified in a compose file
# using:
#   command:
#       - ...
#       - ...
#

# This script is being ran before searx starts
# This way we can edit `/etc/searx/settings.yaml` to set our secrets

SETTINGS_FILE="$1"
SECRET_FILE="$2"
shift 2


set_secret() {
    SETTINGS_FILE="$1"
    SECRET_FILE="$2"
    shift 2

    cp "${SETTINGS_FILE}" "${SETTINGS_FILE}.tmp" 
    sed -i -e "s/CHANGE_THIS/$(sed 's:/:\\/:g' ${SECRET_FILE})/" "${SETTINGS_FILE}.tmp"
    cat "${SETTINGS_FILE}.tmp" > "${SETTINGS_FILE}"
}

set_secret "${SETTINGS_FILE}" "${SECRET_FILE}"
